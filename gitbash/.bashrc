#!/bin/bash

cptid() {
  # only valid for vscode
  file_name=$(code -s | grep window | awk -F '[()]' '{print $2}' | sed -e 's/ -.*//')
  # file_name="HYD_508S_20212_DetectionMassiveLeakageDIALYSIS__ResetAfterePHT_1.py"
  project_dir="$HOME/Diamond_HiL_TestAutomation"

  if [[ -z "$file_name" ]]; then
    echo "No file is currently open in VS Code."
    return 1
  fi

  case "$file_name" in
  *HYD*)
    file_path="${project_dir}/hydraulics/Python/TestPool/${file_name}"
    ;;
  *EBM*)
    file_path="${project_dir}/ebm/Python/TestPool/${file_name}"
    ;;
  *)
    echo "$file_name is not a Testcase"
    return 1
    ;;
  esac

  if [[ -z "$file_path" ]]; then
    echo "File not found: $file_name"
    return 1
  fi

  # Extract the ID from the file
  id=$(grep '^TC_ID\s*=\s*['"'"'"]' "$file_path" | sed -e 's/^[^'"'"'"]*['"'"'"]\([^'"'"'"]*\)['"'"'"].*/\1/' | xargs echo -n)

  if [[ -z "$id" ]]; then
    echo "No Testcase ID found in $file_name"
    return 1
  fi

  # Copy ID to clipboard
  echo "$id" | /c/Windows/System32/clip.exe

  echo "Testcase ID in clipboard: $id (filename: $file_name)"
}

function polup {
  local current_dir=$(pwd)
  cd $HOME/PolarionUploader
  ./PolarionUploader.exe
  cd "$current_dir"

}

function cpcid {
  if [ -d ".git" ]; then
    commitId=$(git log -1 --pretty=format:%H)
    echo -n "$commitId" | /c/Windows/System32/clip.exe
    echo "Git commit ID in clipboard: $commitId"
  else
    echo "$(pwd) is not a Git repo."
  fi
}

function cpreq {
  powershell.exe -Command "cpreq"
}

function cpbranch {
  powershell.exe -Command "cpbranch"
}

# Bash Functions for Directories
tetsdir() {
  cd "$HOME/Desktop/TETs"
}

workdir() {
  cd "$HOME/Diamond_HiL_TestAutomation"
}

devdir() {
  cd "$HOME/dev"
}

goarti() {
  cd "$HOME/Desktop/artifacts"
}

# Bash Functions for VS Code
codesb() {
  code "$HOME/Desktop/sandbox"
}

codetodo() {
  code "$HOME/Desktop/TODO.txt"
}

# Bash Functions for Vim
vimtodo() {
  vim "$HOME/Desktop/TODO.txt"
}

vimrev() {
  vim "$HOME/Desktop/acceptance_review_notes.txt"
}

alias cofiles='~/scripts/checkout_files.sh'

alias ls='ls --color=auto'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias ll='ls -l --color=auto'
alias la='ls -la --color=auto'
alias l='ls -CF --color=auto'
alias ls='ls --color=auto'
