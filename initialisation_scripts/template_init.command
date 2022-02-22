#!/usr/bin/env bash
#
# update template submodules manually
# run once in the main folder after the template has been made by tonic

# readme text
syncopt="template3test is the parent directory"

# Set folder where script will be executed 
loc=$(dirname $0)
projectdir=$(git -C ${loc} rev-parse --show-toplevel)

pushd ${loc} > /dev/null

git submodule update --init --recursive
echo .DS_Store >> .gitignore

echo "$syncopt" >> 03_data/001_data/README_data.md
echo "$syncopt" >> 04_data_analysis/010_code/README_analysiscode.md
echo "$syncopt" >> 05_figures/990_shared_figures/README_figures.md
echo "$syncopt" >> 03_data/001_data/README_data.md
echo "$syncopt" >> 06_dissemination/README_DISSEMINATION.md
touch 06_dissemination/01_reports_conferences/.gitkeep
touch 06_dissemination/02_manuscripts/.gitkeep
touch 06_dissemination/03_other/.gitkeep


git submodule foreach gin init
git submodule foreach gin commit . -m initial commit from template
git submodule foreach gin upload

git checkout --orphan newbranch
git add -A
git commit -m "created from template"
git branch -D main
git branch -m main
git push -f origin main
