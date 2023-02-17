Set-PSReadlineKeyHandler -Key ctrl+d -Function ViExit
function which { (Get-Command $args).Definition }
Set-Alias vim nvim
Set-Alias lg lazygit

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
    if($dirty) {
      $str += "*"
    }
    return $str;
  } catch { return "" }
}

function Get-Role {
  $identity  = [Security.Principal.WindowsIdentity]::GetCurrent()
  $principal = [Security.Principal.WindowsPrincipal] $identity
  $adminRole = [Security.Principal.WindowsBuiltInRole]::Administrator

  $(if (Test-Path variable:/PSDebugContext) { '[DBG]: ' }
    elseif($principal.IsInRole($adminRole)) { '[ADMIN]: ' }
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
