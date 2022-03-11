Need to be updated to show latest PR changes.

# synchronisation_scripts
This repository is a home for our work on synchronisation script. The scripts should synchronise git repositories upon double click.
This work was started at https://gin.g-node.org/gin4RRI/gin-scripts/, and then moved to GitHub (in order to get all work under the same team umbrella.)

Scripts for working with GIN server using the GIN client.


## Bash script for Linux and macOS

The script was only tested in macOS.

[sync](./sync): Run from inside a repository to upload any local changes to GIN using the GIN CLI.

- Assumes the repository is already initialized and you are logged in into gin (via `gin login` or via ssh).
- work with submodules.
- Synchronises changes made remotely (on the server) and locally (on the local machine).
- Does not download large files and do not delete large files content after upload by default. Change variable `syncopt="remove"` in line 19 to modify this behavior. Current option is download, keep and remove.
- Double clicking on the file in a file browser should run the script in a terminal. If the script succeeds, the terminal closes immediately.  If there is an error, it will print an error message and wait for the user to press [Enter] or close the window.
- You may need to make the script an executable: open a terminal window in your repository folder (right-click -- New Terminal at folder) and run `chmod +x sync`. This needs only to be done once.

See issues for future developments.

## Windows

We are still looking for a way to use the bash script in windows. Another approach is to use .bat scripts.


## Initiation scripts

GIN scripts suppose that the user is using the main g-node GIN server. Scripts in this folder will set up connection to a different instance.

Note: when using several server, you can use `gin servers` to see a list and check that nothing went rogue. If you ever get the gin server changed, you can get if back with `gin add-server --web https://gin.g-node.org:443 --git git@gin.g-node.org:22 gin`


# Contritubion

Feel welcome to contribute to this project by giving us feedback via issues, or by changing the code directly via a Pull Request. 
