#!/usr/bin/env bash
#
# update template submodules manually
# run once in the main folder after the template has been made by tonic



# Set folder where script will be executed 
loc=$(dirname $0)
projectdir=$(git -C ${loc} rev-parse --show-toplevel)

pushd ${loc} > /dev/null



# readme text
readmetext="template3test is the parent directory"

git submodule update --init --recursive

# if the template was not initialise before, let's do it 
if test -f "03_data/001_data/README_data.md" ;
then
echo "submodules in place, happy working!"
else
echo "setting up the template for the first time !"
echo .DS_Store >> .gitignore

echo "$readmetext" >> 03_data/001_data/README_data.md
echo "$readmetext" >> 04_data_analysis/010_code/README_analysiscode.md
echo "$readmetext" >> 05_figures/990_shared_figures/README_figures.md
echo "$readmetext" >> 03_data/001_data/README_data.md
echo "$readmetext" >> 06_dissemination/README_DISSEMINATION.md
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
    
fi