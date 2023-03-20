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
# go on main branch
git checkout main

GINinfo="$(gin remotes)"
Gitadress="$(echo $GINinfo | cut -d'/' -f3)"

Orga="$(echo $GINinfo | cut -d'/' -f4)"
repo2="$(echo $GINinfo | cut -d'/' -f5)"
repo="$(echo $repo2 | cut -d' ' -f1)"
reposhort="$(echo "${repo/.main}")"


# readme text
readmetext="$Gitadress/$Orga/$repo is the parent directory"

echo "readme will be $readmetext"

# initialise submodules
git submodule update --init --recursive

# if the template was not initialise before, let's do it
if test -f "03_data/001_data/README_data.md" ;
then
    echo "submodules in place, happy working!"
else
    echo "setting up the template for the first time !"
    
    # add readme files, and folders
    echo "$readmetext" >> 03_data/001_data/README_data.md
    echo "$readmetext" >> 04_data_analysis/010_code/README_analysiscode.md
    echo "$readmetext" >> 05_figures/990_shared_figures/README_figures.md
    echo "$readmetext" >> 03_data/001_data/README_data.md
    echo "$readmetext" >> 06_dissemination/README_DISSEMINATION.md
    mkdir 06_dissemination/01_reports_conferences
    mkdir 06_dissemination/02_manuscripts
    mkdir 06_dissemination/03_other
    touch 06_dissemination/01_reports_conferences/.gitkeep
    touch 06_dissemination/02_manuscripts/.gitkeep
    touch 06_dissemination/03_other/.gitkeep
    
    # add labcommons submodule
    git submodule add "ssh://$Gitadress/$Orga/"labcommons"" testlabcommons
    
    # push submodule content
    git submodule foreach gin init
    git submodule foreach gin commit . -m initial commit from template
    git submodule foreach gin upload
    
    # delete file telling the initialisation need to be done
    rm "00repo_needs_initialisation00.txt"

    # arrange parent repository
    gin commit .
    
    git checkout --orphan newbranch
    git add -A
    git commit -m "created from template"
    git branch -D main
    git branch -m main
    git push -f origin main
    
    # add submodule to PI repo
    # get labreports repo and write new folder for the project
    cd ../
    gin get ""$Orga""/labreports""
    cd labreports
    mkdir "$reposhort"
    mkdir "$reposhort/05_figures"
    
    
    # add 2 submodule for figures and dissemination files there
    
    git submodule add "../$reposhort.05_figures_990_shared_figures.git" ""$reposhort"/05_figures/990_shared_figures"
    git submodule add "../$reposhort.06_dissemination" ""$reposhort"/06_dissemination"
    
    # add a file to tell the user/script to initialise the submodules next time.
    
    echo "submodules need intitialisation due to project $repo " >> "initialise.txt"
    
    # push changes on the server and remove the repo from the computer.
    gin commit . -m "added project $reposhort"
    gin upload
    cd ../
    rm -rf labreports
fi