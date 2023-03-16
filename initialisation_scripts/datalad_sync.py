from heapq import merge
import os
import sys

import datalad.api as dl

# Set folder where script will be executed
loc = os.path.dirname(os.path.abspath(__file__))
print(loc)
os.chdir(loc)
#projectdir = dl.Repo(loc, create=False).get_toppath()

# initialise
if not os.path.isfile("06_dissemination/README_DISSEMINATION.md"):
    print("running project repository initiation (first run)")
    dl.get(".", recursive=True, get_data=False)
    dl.update(merge=True, recursive=True)

# Set commit message
commitmessage = input("Optionally enter a commit message, and hit return: ")
if not commitmessage:
    print("using date as commit message")
    commitmessage = "commit on" + {datetime.now().strftime('%Y-%m-%d')}

# sync
dl.update(merge=True, recursive=True)
dl.save(".", message=commitmessage, recursive=True)
dl.push(".", to="origin", recursive=True)

# Set dropping option
q_answer = input("Do you want to drop all files that were uploaded, they will be on the server but not on this computer anymore ? [y/n]")
if q_answer == "y":
    dl.drop(".", recursive=True)
