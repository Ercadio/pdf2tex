#!/usr/bin/env bash

function error(){
        echo -e "\x1b[31mERROR: ${1}\x1b[0m"
        read anykey
        exit 1
}

function title(){
        echo -e "\n\x1b[7m[ $1 ]\x1b[0m"
}

title "Verifying Python"
versionName=$(python --version)
versionRegex="([0-9])\.([0-9])\.([0-9])"
if [[ $versionName =~ $versionRegex ]]; then
    if [[ ${BASH_REMATCH[1]} -ge 3 ]]; then
      version="${BASH_REMATCH[0]}"
      echo "Python ${version} found!"
    else
      error "You are using an older version of Python(${BASH_REMATCH[0]}). Please upgrade to Python 3"
    fi
else
    error "Python was not found"
fi

title "Creating virtual environment"
python -m venv env || error "Could not create python virtual environment"

title "Installing dependencies"
source env/Scripts/activate
pip install --upgrade pip
pip install -r requirements.txt
