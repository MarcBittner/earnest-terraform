#!/bin/bash

RequireProgram() {

  local scriptName debugOutput
  unset ${scriptName} ${debugOutput}
  scriptName="$(basename "$(test -L "$0" && readlink "$0" || echo "$0")")"
  debugOutput=1

  command -v ${1} >/dev/null 2>&1 &&
    { echo >&2 "${ScriptName} requires ${1} and it is installed."; return 0
      } ||
    { echo >&2 "${ScriptName} requires ${1} but it's not installed.  Aborting."; return 1;
      }
}

RequireProgram find
RequireProgram terraform-docs


find . ! -path . -type d -exec bash -c 'terraform-docs md "{}" > "{}"/README.md;' \;
find . ! -path . -type d -name "README.md" -size 1c -type f -delete

printf "\n\033[35;1mUpdating the following READMEs with terraform-docs\033[0m\n\n"

find . -name "README.md"
