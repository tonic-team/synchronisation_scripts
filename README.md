Need to be updated to show latest PR changes.

# synchronisation_scripts

This repository is a home for the tonic team work on synchronisation script. The scripts should synchronize git repositories upon double click.
This work was started at https://gin.g-node.org/gin4RRI/gin-scripts/, and then moved to GitHub (in order to get all work under the same team umbrella.)

## version 1.0

- Scripts for working with GIN server using the GIN client.
- Both initialise and synchronise tonic-created repositories with submodules
- `INIT-SYNC` is the master script calling scripts present in .script folder
- The current scripts are made and tested for tonic-created repositories on the HU server. We are looking into making them work with usual gin repositories.

See issues for future developments.



## Installation

- install gin-cli: see https://gin.g-node.org/G-Node/Info/wiki/GIN+CLI+Setup 
- paste the `INIT-SYNC` file and the `.script` folder in the parent repository.
- add `INIT-sync`  to `.gitignore` (so it is not update if the variable is changed) .
- You may need to make the script an executable: open a terminal window in your repository folder (right-click -- New Terminal at folder) and run `chmod +x INIT-sync`. This needs only to be done once.
- You may open in a text editor and modify the value of `syncopt` (l.76) if you want the script to dowload or erase all annexed files in/from your local copy.

NB: windows users will need special installation, see [this file](./windows-workflow.md)



## Bash script for Linux and macOS

The script was only tested in macOS.

[INIT-sync](./INIT-sync): Run from inside a repository to upload any local changes to GIN using the GIN-CLI.

## master script

- Double clicking on the file in a file browser should run the script in a terminal. If the script succeeds, the terminal closes immediately.  If there is an error, it will print an error message and wait for the user to press [Enter] or close the window.
- The script will call a repository initialisation script (tonic v.0.9 is not able to do it all), a submodule initialisation (first time the synchronisation is runned, the submodules need to be downloaded and set), and finally the synchronisation script.
- Initialisation is based on `gin git` commands and do not need extra ssh access (gin provides it).


## synchronisation part
- Assumes the repository is already initialized and you are logged in into gin (via `gin login` or via ssh).
- work with submodules.
- Synchronises changes made remotely (on the server) and locally (on the local machine).
- Does not download large files and do not delete large files content after upload by default. Change variable `syncopt="remove"` in line 19 to modify this behavior. Current option is download, keep and remove.
- ask for a "commit message"", the message will be used in the main repo, and in submodules commits. This is useful to track what has been changed when looking at the history.





## Windows

We are still looking for a way to use the bash script in windows. Another approach is to use .bat scripts to call the bash script. See [this file](./windows-workflow.md) 

## other (older) scripts

### Initiation scripts

GIN scripts suppose that the user is using the main g-node GIN server. Scripts in this folder will set up connection to a different instance.

Note: when using several server, you can use `gin servers` to see a list and check that nothing went rogue. If you ever get the gin server changed, you can get if back with `gin add-server --web https://gin.g-node.org:443 --git git@gin.g-node.org:22 gin`

This should be working inside the main initialisation script now.

# Contritubion

Feel welcome to contribute to this project by giving us feedback via issues, or by changing the code directly via a Pull Request. 