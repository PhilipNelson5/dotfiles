Set-PSReadlineKeyHandler -Key ctrl+d -Function ViExit
Set-Alias vim nvim
Set-Alias lg lazygit

function push { git push $args }
function pull { git pull $args }
function path { $env:path -split ";" }
function which { (Get-Command $args).Definition }
function mkdocs { docker run --rm -it -p 8000:8000 -v ${PWD}:/docs gitlab.tenonespace.com:5001/devops/docker-images/mkdocs:0.1.7 $args }
function reload {
    . $PROFILE
    Write-Host "PowerShell profile reloaded!" -ForegroundColor Cyan
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

function mktemp {
  $tempFileName = [System.IO.Path]::GetTempFileName()
  Remove-Item -Path $tempFileName -Force
  New-Item -Path $tempFileName -ItemType Directory | Out-Null
  Set-Location $tempFileName
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
