Set-PSReadlineKeyHandler -Key ctrl+d -Function ViExit
Set-Alias vim nvim
Set-Alias lg lazygit

function reload {
  . $PROFILE
  Write-Host "PowerShell profile reloaded!" -ForegroundColor Cyan
}
function push { git push $args }
function pull { git pull $args }
function path { $env:path -split ";" }
function which { (Get-Command $args).Definition }
function mkdocs { docker run --rm -it -p 8000:8000 -v ${PWD}:/docs gitlab.tenonespace.com:5001/devops/docker-images/mkdocs:0.1.7 $args }
function c {
  param(
    [Parameter(Position = 0)]
    [string]$Target
  )

  if ([string]::IsNullOrWhiteSpace($Target)) {
    # No argument: interactively select a tracked directory
    $path = zoxide query --interactive
    if ([string]::IsNullOrWhiteSpace($path)) { return }
    $resolved = Resolve-Path -LiteralPath $path -ErrorAction SilentlyContinue
    if ($resolved) {
      zoxide add $resolved.Path
      code $resolved.Path
    }
  }
  elseif (Test-Path -LiteralPath $Target) {
    # Target exists relative to the current directory
    $resolved = Resolve-Path -LiteralPath $Target
    zoxide add $resolved.Path
    code $resolved.Path
  }
  else {
    # Query zoxide using the provided string
    $path = zoxide query $Target 2>$null
    if ([string]::IsNullOrWhiteSpace($path)) {
      Write-Host "No match"
      return
    }
    $resolved = Resolve-Path -LiteralPath $path -ErrorAction SilentlyContinue
    if ($resolved) {
      Write-Host "Opening $resolved"
      zoxide add $resolved.Path
      code $resolved.Path
    }
  }
}

function repo {
  <#
    .SYNOPSIS
        Finds the nearest git root, converts the origin URL to HTTPS, and opens it.
  #>

  $currentPath = $ExecutionContext.SessionState.Path.CurrentLocation.Path
  $gitDir = $null

  # Loop until we find .git or hit the top of the file system
  while ($currentPath) {
    if (Test-Path (Join-Path $currentPath ".git")) {
      $gitDir = $currentPath
      break
    }
    $currentPath = Split-Path $currentPath -Parent
  }

  if (-not $gitDir) {
    Write-Host "No git repository found"
    return
  }

  # Get the origin URL using git directly
  $url = Set-Location $gitDir -PassThru | ForEach-Object {
    git remote get-url origin 2>$null
  } | Select-Object -First 1

  # Back to where we started
  Set-Location $ExecutionContext.SessionState.Path.CurrentLocation.Path

  if (-not $url) {
    Write-Error "Could not find a remote named 'origin' in $gitDir"
    return
  }

  # Convert SSH format to HTTPS
  # Pattern 1: git@github.com:user/repo.git
  if ($url -match '^git@([^:]+):(.+)') {
    $domain = $Matches[1]
    $path = $Matches[2] -replace '\.git$', ''
    $url = "https://$domain/$path"
  }
  # Pattern 2: ssh://git@github.com/user/repo.git
  elseif ($url -match '^ssh://git@([^/]+)/(.+)') {
    $domain = $Matches[1]
    $path = $Matches[2] -replace '\.git$', ''
    $url = "https://$domain/$path"
  }

  Write-Host "Opening: $url" -ForegroundColor Cyan
  Start-Process $url
}

# POSIX-like commands
if (Get-Alias rm -ErrorAction SilentlyContinue) { Remove-Item Alias:rm -Force }
function rm {
  [CmdletBinding()]
  param(
    [Parameter(ValueFromPipeline = $true, Position = 0, Mandatory = $true, ValueFromRemainingArguments = $true)]
    [string[]]$Path,
    [Alias("r")]
    [switch]$Recursive,
    [Alias("f")]
    [switch]$Force,
    [switch]$rf
  )
  process {
    $rmArgs = @{}
    if ($Recursive -or $rf) { $rmArgs["Recurse"] = $true }
    if ($Force -or $rf) {
      $rmArgs["Force"] = $true
      $rmArgs["ErrorAction"] = "SilentlyContinue"
    }
    Remove-Item -Path $Path @rmArgs
  }
}

function touch {
  [CmdletBinding()]
  param(
    [Parameter(ValueFromPipeline = $true, Position = 0, Mandatory = $true, ValueFromRemainingArguments = $true)]
    [string[]]$Path
  )
  process {
    foreach ($p in $Path) {
      if (Test-Path $p) {
        (Get-Item $p).LastWriteTime = Get-Date
      }
      else {
        New-Item -Path $p -ItemType File -Force | Out-Null
      }
    }
  }

}

function mktemp {
  $tempFileName = [System.IO.Path]::GetTempFileName()
  Remove-Item -Path $tempFileName -Force
  New-Item -Path $tempFileName -ItemType Directory | Out-Null
  Set-Location $tempFileName
}

function time {
  $Command = "$args"
  Measure-Command {
    Invoke-Expression $Command 2>&1 | Out-Default
  }
}

function open {
  param(
    [Parameter(ValueFromPipeline = $true, Position = 0)]
    [string]$Path = "."
  )

  # 1. Resolve the path to get the full system path
  $resolvedPath = Resolve-Path $Path -ErrorAction SilentlyContinue | Select-Object -ExpandProperty Path

  # 2. Fallback if Resolve-Path fails (e.g., a file that hasn't been saved yet)
  if (-not $resolvedPath) { $resolvedPath = $Path }

  # 3. Check if the path exists
  if (Test-Path $resolvedPath) {
    if (Test-Path $resolvedPath -PathType Container) {
      # It's a folder: Open in File Explorer
      Start-Process "explorer.exe" -ArgumentList "`"$resolvedPath`""
    }
    else {
      # It's a file: Open with the default associated program
      Start-Process $resolvedPath
    }
  }
  else {
    Write-Error "The path '$Path' doesn't exist."
  }
}

# Zoxide
if (Get-Command zoxide) {
  Invoke-Expression (& { (zoxide init powershell --cmd cd | Out-String) })
}

# FzF
if (Get-Module -ListAvailable -Name PsFzf) {
  Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'
}

# Python Venv
function activate {
  [CmdletBinding()]
  param(
    # Root to search (defaults to current directory)
    [Parameter(Position = 0)]
    [string] $Path = ".",

    # Override the list of venv directory names (search order matters)
    [string[]] $Names = @(".venv", "venv", "env", ".env", ".python-venv", ".virtualenv"),

    # Show what the function is doing
    [switch] $VerboseOutput
  )

  # Resolve the search root to a full path
  $root = Convert-Path -LiteralPath $Path -ErrorAction SilentlyContinue
  if (-not $root) {
    Write-Error "Path not found: $Path"
    return
  }

  if ($VerboseOutput) { Write-Host "Searching for virtual environments in: $root" -ForegroundColor Cyan }

  foreach ($name in $Names) {
    $candidate = Join-Path $root $name

    if (-not (Test-Path -LiteralPath $candidate -PathType Container)) {
      if ($VerboseOutput) { Write-Host "Not found: $candidate" -ForegroundColor DarkGray }
      continue
    }

    $winActivate = Join-Path $candidate "Scripts\Activate.ps1" # Windows

    $activateScript = $null
    if (Test-Path -LiteralPath $winActivate -PathType Leaf) {
      $activateScript = $winActivate
    }

    if ($activateScript) {
      if ($VerboseOutput) { Write-Host "Activating venv: $candidate" -ForegroundColor Green }
      & $activateScript
      return
    }
    else {
      if ($VerboseOutput) {
        Write-Host "Directory found but no PowerShell activation script: $candidate" -ForegroundColor Yellow
      }
    }
  }

  Write-Warning "No Python virtual environment found in '$root' (searched: $($Names -join ', '))."
}

function New-Venv {
  [CmdletBinding(SupportsShouldProcess)]
  param(
    [Parameter(Position = 0)]
    [ValidateNotNullOrEmpty()]
    [string] $Name = ".venv",
    [switch] $Force # If set, re-creates the venv by deleting the target dir if it already exists.
  )

  # Resolve target path in the current directory
  $targetPath = Join-Path -Path (Get-Location) -ChildPath $Name

  # Handle existing directory
  if (Test-Path -LiteralPath $targetPath -PathType Container) {
    if ($Force) {
      if ($PSCmdlet.ShouldProcess($targetPath, "Remove existing venv directory")) {
        try { Remove-Item -LiteralPath $targetPath -Recurse -Force -ErrorAction Stop }
        catch {
          Write-Error "Failed to remove existing directory '$targetPath': $($_.Exception.Message)"
          return
        }
      }
    }
    else {
      Write-Warning "Directory '$targetPath' already exists. Use -Force to recreate."
      return
    }
  }

  # Create the venv
  try {
    python -m venv "$targetPath"
    if ($LASTEXITCODE -ne 0) {
      Write-Error "Python reported a non-zero exit code ($LASTEXITCODE) while creating the venv."
      return
    }
  }
  catch {
    Write-Error "Failed to create virtual environment: $($_.Exception.Message)"
    return
  }

  activate
}

function New-Temp-Venv {
  mktemp
  new-venv
}

# git prompt
if (Get-Module -ListAvailable -Name posh-git) {
  Import-Module posh-git
  $GitPromptSettings.DefaultPromptEnableTiming = $true
  $GitPromptSettings.DefaultPromptAbbreviateHomeDirectory = $true
  $GitPromptSettings.BeforePath.Text = "$env:UserName@$env:ComputerName "
  $GitPromptSettings.BeforeStatus.Text = '('
  $GitPromptSettings.AfterStatus.Text = ')'
  $GitPromptSettings.BeforeStatus.ForegroundColor = [ConsoleColor]::DarkYellow
  $GitPromptSettings.AfterStatus.ForegroundColor = [ConsoleColor]::DarkYellow
  $GitPromptSettings.BranchColor.ForegroundColor = [ConsoleColor]::DarkYellow
  $GitPromptSettings.BeforePath.ForegroundColor = [ConsoleColor]::Green
  function prompt {
    $prompt = "PS "
    $prompt += & $GitPromptScriptBlock
    if ($prompt) { "$prompt" } else { " " }
  }
}
else {
  function Get-BranchName {
    try {
      $branch = git rev-parse --abbrev-ref HEAD
      $str = ""
      if ($branch -eq "HEAD") {
        $str += " ("
        $str += git rev-parse --short HEAD
        $str += ")"
      }
      elseif ($branch) {
        $str += " ($branch)"
      }
      $dirty = git status --porcelain
      if ($dirty) {
        $str += "*"
      }
      return $str;
    }
    catch { return "" }
  }

  function Get-Role {
    $identity = [Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = [Security.Principal.WindowsPrincipal] $identity
    $adminRole = [Security.Principal.WindowsBuiltInRole]::Administrator

    $(if (Test-Path variable:/PSDebugContext) { '[DBG]: ' }
      elseif ($principal.IsInRole($adminRole)) { '[ADMIN]: ' }
      else { '' }
    )
  }

  function prompt {
    $path = "$($executionContext.SessionState.Path.CurrentLocation)"
    $branch = $(Get-BranchName)
    Write-Host -NoNewline $(Get-Role)
    Write-Host -NoNewline "PS "
    Write-Host -NoNewline "$env:UserName@$env:ComputerName" -ForegroundColor "green"
    Write-Host -NoNewline ":" -ForegroundColor "white"
    Write-Host -NoNewline $path -ForegroundColor "blue"
    Write-Host -NoNewline $branch -ForegroundColor "DarkYellow"
    return "$('>' * ($nestedPromptLevel + 1)) "
  }
}
