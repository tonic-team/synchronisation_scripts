# Tonic Synchronisation_scripts

This repository is a home for the tonic team work on synchronisation script.
The scripts synchronize git repositories upon double click.
While Unix users can choose between GIN-CLI and datalad based scripts, windows users should use datalad scripts.
Some more information can be read at https://gin-tonic.netlify.app/tooling/synchronisationscripts/

## Use

Executable scripts should be in the main parent folder of the parent repository, the .scripts hidden folder should also be copied there. If you want to have both scripts available, you will need to combine the two .scritps folder.

## History

This work was started at <https://gin.g-node.org/gin4RRI/gin-scripts/>, and then moved to GitHub (in order to get all work under the same team umbrella.) We first work on scripts using GIN-CLI, as the tonic template did not have submodules.
We then moved to use datalad in scripts, as it is easier to make it work on windows machine, and make it probably easier to handle on the long run, as datalad is made to work with submodules (GIN-Cli is not).

## Repo organisation

We put scripts based on datalad and those based on GIN-CLI is two different folders, while old code used at different time is in the `tests\` repository.

# Requirement

The datalad scripts require datalad to be installed, and a ssh conection between your computer and the online repository.
It also needs python 3 to be installed (this is usually also a requirement for datalad).
The GIN_CLI scripts requires to install the GIN-cli tool, set the GIN server (see initialisation scripts), and run bash scripts on your machine (difficulties in windows computers).

Note that the scripts are meant to be used with a special tonic repository created following https://gin-tonic.netlify.app/installation/template_repository/, especially we used the `git annex config --set annex.addunlocked true` option such that annexed files are not locked: it takes more space, but allows windows users to work on annexed files.


# Datalad scripts

The datalad scripts contains one bash and one .bat script to be executed on UNIX or windows computer, both should work out of the box, as they are only calling a python script.

The pyhton script ask for a commi message and then update the repository with the server version. 
In a second step, its asks wether large files should be dropped from the hard disc (this is done only if the server version has been uploaded successfully).
Getting dropped files should be done manually using `datalad get .` (to get is all).

### Installation

For the python scripts to work, python 3 and datalad should be installed.
Please refer to the [datalad handbook](http://handbook.datalad.org/en/latest/index.html#) for the installation of both (datalad requires python3), as well as ssh connections. 

*The \`set a ssh connection\` step may be a bit complicated, please refer also to the [datalad handbook](http://handbook.datalad.org/en/latest/index.html#).* My advice is to use [Rstudio to set your ssh key](https://happygitwithr.com/ssh-keys.html), it is much faster than going through the command line interface.

You should also first get the repository using `datalad clone <ssh address of the repo>` (this will run in the command line on windows and the terminal on UNIX machines).
For this to work, one needs a working ssh connection.



On unix machines, the bash script should be made executable.

-    Open the terminal in the folder where the script is (right click the folder, alternatively, open a terminal, type `cd` and then drag and drop the folder in the terminal).
-   run `chmod +x sync_unix`

### Troubleshoot

-OSX
  - one needs to install datalad via homebrew **and** via pip3 (otherwise the python datalad API is not installed: `brew install datalad`, `pip3 install datalad`)
- Windows
  - It may be tricky to install everything on Windows. Especially ssh keys do not work the same. If you can reinstall everything fresh when you encounter an issue with the installation.
  
  
# GIN-CLI scripts

## Overview

-   Scripts for working with GIN server using the GIN client.
-   Both initialise and synchronise tonic-created repositories with submodules
-   `sync-gin-unix` is the master script calling scripts present in .script folder
-   The current scripts are made and tested for tonic-created repositories on the HU server.

## Installation

-   install gin-cli: see <https://gin.g-node.org/G-Node/Info/wiki/GIN+CLI+Setup>
-   paste the `sync-gin-unix` file and the `.script` folder in the parent repository.
-   You may need to make the script an executable: open a terminal window in your repository folder (right-click -- New Terminal at folder) and run `chmod +x sync-gin-unix`. This needs only to be done once.
-   You may open in a text editor and modify the value of `syncopt` (l.76) if you want the script to dowload or erase all annexed files in/from your local copy.
- If you want a script specific for a single computer, copy paste the script, add a different name, and add that new file to .gitignore **before** using it to synchronise the repository.

NB: windows users will need special installation, see [this file](./03_helpers-gincli/windows-workflow.md)

## Bash script for Linux and macOS

The script was only tested in macOS.

[sync-gin-unix](./sync-gin-unix): Run from inside a repository to upload any local changes to GIN using the GIN-CLI.

## master script

-   Double clicking on the file in a file browser should run the script in a terminal. If the script succeeds, the terminal closes immediately. If there is an error, it will print an error message and wait for the user to press [Enter] or close the window.
-   The script will call a repository initialisation script, a submodule initialisation (first time the synchronisation is runned, the submodules need to be downloaded and set), and finally the synchronisation script.
-   Note: initialisation is based on `gin git` commands and do not need extra ssh access (gin provides it).

## synchronisation part

-   Assumes you are logged in into gin (via `gin login` or via ssh) and using the HU server.
-   work with submodules.
-   Synchronises changes made remotely (on the server) and locally (on the local machine).
-   Does not download large files and do not delete large files content after upload by default. Change variable `syncopt="remove"` in line 19 to modify this behavior. Current option is download, keep and remove.
-   ask for a "commit message"", the message will be used in the main repo, and in submodules commits. This is useful to track what has been changed when looking at the history.

## On Windows

One approach is to use .bat scripts to call the bash script.
See [this file](./windows-workflow.md), but please condider using the datalad scripts instead.

## other scripts

### Initiation scripts

GIN scripts suppose that the user is using the main g-node GIN server.
Scripts in this folder will set up connection to a different instance.

Note: when using several server, you can use `gin servers` to see a list and check that nothing went rogue.
If you ever get the gin server changed, you can get if back with `gin add-server --web https://gin.g-node.org:443 --git git@gin.g-node.org:22 gin`

This should be working inside the main initialisation script now.

# Contritubion

Feel welcome to contribute to this project by giving us feedback via issues, or by changing the code directly via a Pull Request.
