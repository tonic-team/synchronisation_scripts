#!/usr/bin/env bash
#
# update template submodules manually
# run once in the main folder after the template has been made by tonic



# Set folder where script will be executed
#loc=$(dirname $0)
#projectdir=$(git -C ${loc} rev-parse --show-toplevel)
#
#pushd ${loc} > /dev/null

# get info for gin remote information

GINinfo="$(gin remotes)"
Gitadress="$(echo $GINinfo | cut -d'/' -f3)"

Orga="$(echo $GINinfo | cut -d'/' -f4)"
repo2="$(echo $GINinfo | cut -d'/' -f5)"
repo="$(echo $repo2 | cut -d' ' -f1)"
reposhort="$(echo "${repo/.main}")"


# readme text
readmetext="$Gitadress/$Orga/$repo is the parent directory"
gitign=".DS_Store"

echo "readme will be $readmetext"

echo "erase master branch and go to main if there is a main branch"
gin git checkout main
gin git branch -D master

# initialise submodules
gin git submodule update --init --recursive

# if the template was not initialise before, let's do it
if test -f "03_data/001_data/README_data.md" ;
then
    echo "submodules in place, happy working!"
else
    echo "setting up the template for the first time !"
    
    # add readme files, and folders
    echo "$readmetext" >> 03_data/001_raw_data/README_dataraw.md
    echo "$readmetext" >> 04_data_analysis/010_code/README_analysiscode.md
    echo "$readmetext" >> 05_figures/990_shared_figures/README_figures.md
    echo "$readmetext" >> 03_data/001_derived_data/README_dataderived.md
    echo "$readmetext" >> 06_dissemination/README_DISSEMINATION.md
    
    echo "$gitign" >> 03_data/001_raw_data/.gitignore
    echo "$gitign" >> 04_data_analysis/010_code/.gitignore
    echo "$gitign" >> 05_figures/990_shared_figures/.gitignore
    echo "$gitign" >> 03_data/001_derived_data/.gitignore
    echo "$gitign" >> 06_dissemination/.gitignore
    
    mkdir 06_dissemination/01_reports_conferences
    mkdir 06_dissemination/02_manuscripts
    mkdir 06_dissemination/03_other
    touch 06_dissemination/01_reports_conferences/.gitkeep
    touch 06_dissemination/02_manuscripts/.gitkeep
    touch 06_dissemination/03_other/.gitkeep
    
    # add labcommons submodule
    gin git submodule add "../labcommons" 07_misc/labcommons
    
    # push submodule content
    gin git submodule foreach gin init
    gin git submodule foreach gin commit . -m initial commit from template
    gin git submodule foreach gin upload
    
    # delete file telling the initialisation need to be done
    rm "00repo_needs_initialisation00.txt"

    # arrange parent repository (no rewriting history for security issue)
    gin git commit . -m "initialisation"
    gin upload .

    # add submodule to PI repo
    # get labreports repo and write new folder for the project
    cd ../
    gin get ""$Orga""/labreports""
    cd labreports
    mkdir "$reposhort"
    mkdir "$reposhort/05_figures"
    
    
    # add 2 submodule for figures and dissemination files there
    
    gin git submodule add "../$reposhort.05_figures_990_shared_figures.git" ""$reposhort"/05_figures/990_shared_figures"
    gin git submodule add "../$reposhort.06_dissemination" ""$reposhort"/06_dissemination"
    
    # add a file to tell the user/script to initialise the submodules next time.
    
    echo "submodules need intitialisation due to project "$reposhort"." >> "initialise.txt"

    gin git add "initialise.txt"
   
    # push changes on the server and remove the repo from the computer.
    gin git commit  -m "added project $reposhort"

    gin upload
    cd ../
    rm -rf labreports
fi