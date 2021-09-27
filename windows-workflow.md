# working with windows 

>Tests made on a machine running Windows 8.1, 64 bits withlow internet connection. msys bash that was previously installed on that computer (unknown fact at start of tests :) ).

# Overview

The issue is to make run bash scripts in windows, with the extra issue that the bash script runs git commands. The strategy was to install cygwin with the git packages, set git configuration in cygwin terminal, then use a direct link to cygin bash command in the .bat file. 

# known issues

- one needs to set git config inside cygwin, i.e. probably need to set it twice.


# Installing GIN 

- 135 MB
- extraction takes time

# Installing cygwin

- https://www.cygwin.com/
- download setup.exe 
- no option to choose from until download (parsing)
- choose to install base packages + 
    - git
    - git-gui
    - gitk
    - dos2unix (used to debug sync file line endings)

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
- trying `bash` versus `cygwin\bin\bash`, use dos2unix on sync
- testing on `gin get testorga/Rrepo1.parent`
- works like a charm :)


