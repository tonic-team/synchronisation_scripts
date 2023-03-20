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



# add some submodules to labreport repository.

gin git submodule update --init --recursive

if test -f ".notinlabreport.txt" ;
  then
    # delete file telling the initialisation need to be done
    rm ".notinlabreport.txt"
    
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