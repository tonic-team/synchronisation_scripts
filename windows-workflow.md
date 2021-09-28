# working with windows 

>Tests made on a machine running Windows 8.1, 64 bits with slow internet connection. msys bash that was previously installed on that computer via an old gin-cli installation (unknown fact at start of tests :) ).

# Overview

The issue is to make run bash scripts in windows, with the extra issue that the bash script runs git commands. The strategy was to install cygwin with the git packages, set git configuration in cygwin terminal, then use a direct link to cygwin bash command in the .bat file. 

Since there were issues having gin and git annex in cygwin, I needed to add gin in the batch profile and run the command with the login option (and therefore reuse the curdir code from earlier versions).

# known issues

- one needs to set git config inside cygwin, i.e. probably need to set it twice.
- one needs to play with cygwin environment +  add cygwin to the windows path.


# Installing GIN 

- 135 MB
- extraction takes time
- Put the gin-cli in the C: (so that the path will correspond when adding gin to cygwin)
- run the setup-global.bat file

# Installing cygwin

- https://www.cygwin.com/
- download setup.exe 
- no option to choose from until download (parsing)
- choose to install base packages + 
    - git
    - git-gui
    - gitk
    - dos2unix (used to debug sync file line endings)
- set path for cygwin, for example by running `set PATH=C:\cygwin64\bin;%PATH%` in a cmd window

# Installing gin and git annex for cygwin
- locate the batch file in the cygwin64/home folder
- at the end of the file add path to gin and gin/git binaries so that cygwin can use gin and git annex: paste the following text:
`export PATH="C:\gincli\git\bin;C:\gincli\bin":$PATH`


# setting git info

Open cygwin terminal, type:
git config --global  user.name [yournamehere]
git config --global  user.email [youremailhere]

# run sync.bat via double click

## tests

- gin login
- gin get gin4RRI/scripts-2
- NB that is a miror, as git clone here did not work. (means that gin sync gives an error as the repo is read only.)
- double click sync.bat
- trying `bash` versus `cygwin64\bin\bash`, use dos2unix on sync
- testing on `gin get testorga/Rrepo1.parent`
- works like a charm :)

## getting GIN to work in cygwin

- after changing the path to not include gin-cli stuff, it broke. Trying to get path in cygwin directly:
 - add `export PATH="C:\Users\juliette\Desktop\gincli\git\bin;C:\Users\juliette\Desktop\gincli\bin":$PATH` in batch profile
 
 > working only via cygwin terminal, not using the bash application directly.

- with adding set PATH=C:\cygwin64\bin;%PATH% , then it should be possible to get it working via open .sh file with `cygwin64\bin\bash` ?


