# ---------- dirs ----------
function tetsdir { Set-Location "$HOME\Desktop\TETs" }
function workdir { Set-Location "$HOME\Diamond_HiL_TestAutomation" }
function devdir { Set-Location "$HOME\dev" }
function goarti { Invoke-Item "$HOME\Desktop\artifacts" }
function goarev {start msedge "$HOME\quick_guide_arev.pdf"}

# ---------- vscode ----------
function codesb { code "$HOME\Desktop\sandbox" }
function codetodo { code "$HOME\Desktop\TODO.txt" }

# ---------- vim ----------
function vimtodo { vim "$HOME\Desktop\TODO.txt" }
function vimrev { vim "$HOME\Desktop\acceptance_review_notes.txt" }

# ---------- tools ----------
# PolarionUploader
function polup {
    $appPath = "$HOME\PolarionUploader\PolarionUploader.exe"
    $workingDir = "$HOME\PolarionUploader"
    Start-Process -FilePath $appPath -WorkingDirectory $workingDir -ArgumentList "--width", "1200", "--height", "800"
}

# Copy latest Git commit ID
function cpcid {
    $isGitRepo = Test-Path .git
    $currentDir = Get-Location

    if ($isGitRepo -eq $true) {
        $commitId = git log -1 --pretty=format:%H 
        $trimmedCommitId = $commitId.Trim()
        Set-Clipboard -Value $trimmedCommitId
        Write-Output "Git commit ID in clipboard: $trimmedCommitId"
    }
    else {
        Write-Output "'$currentDir' is not a Git repo."
    }
}


# Copy current Git branch name
function cpbranch {
    $isGitRepo = Test-Path .git
    $currentDir = Get-Location

    if ($isGitRepo -eq $true) {
        $branchName = git branch --show-current
        $trimmedBranchName = $branchName.Trim()
        Set-Clipboard -Value $trimmedBranchName
        Write-Output "Git branch name in clipboard: $trimmedBranchName"
    }
    else {
        Write-Output "'$currentDir' is not a Git repo."
    }
}

# Copy REQ ID digits from the branch name
function cpreq {
    $isGitRepo = Test-Path .git
    $currentDir = Get-Location
    $reqId = ""
    $regexPattern = '(?<=[-_]|^)\d{4,}(?=_|$)'

    if ($isGitRepo -eq $true) {
        $branchName = git branch --show-current
        $trimmedBranchName = $branchName.Trim()
        if ($trimmedBranchName -match $regexPattern) {
            $reqId = [regex]::Matches($trimmedBranchName, $regexPattern).Value
            Set-Clipboard -Value $reqId
            Write-Output "Requirement ID in clipboard: $reqId"
        }
        else {
            Write-Output "Requirement ID not found."
        }
    }
    else {
        Write-Output "'$currentDir' is not a Git repo."
    }
}

# show current Git branch next to prompt
function Get-GitBranch {
    $currentDir = Get-Item . -Force -ErrorAction Ignore

    while ($null -ne $currentDir) {
        $gitDir = Join-Path -Path $currentDir.FullName -ChildPath ".git"

        if (Test-Path $gitDir -PathType Container) {
            # Found the .git directory
            $Query = git rev-parse --abbrev-ref HEAD
            break
        }

        $currentDir = $currentDir.Parent
    }

    $green = [char]27 + '[32m'
    $resetColor = [char]27 + '[0m'

    if ($Query) {
        " $green($Query)$resetColor" 
    }
}

function Get-MyPrompt {
    $branch = Get-GitBranch
    if (-not [string]::IsNullOrWhiteSpace($branch)) {
        $Prompt = "$((Get-Location).Path)$branch`n> "
    }
    else {
        $Prompt = "$((Get-Location).Path)> "
    }
    $Prompt
}

function prompt {
    Get-MyPrompt
}


