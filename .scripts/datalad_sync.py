from datetime import datetime
import os
import sys

import datalad.api as dl

# Set folder where script will be executed
loc = os.path.dirname(os.path.abspath(__file__))
print(loc)
os.chdir(loc)
os.chdir('../')
#projectdir = dl.Repo(loc, create=False).get_toppath()

# initialise
if not os.path.isfile("06_dissemination/README_DISSEMINATION.md"):
    print("running project repository initiation (first run)")
    dl.get(".", recursive=True, get_data=False)
    dl.update(how='merge', recursive=True)

# Give info on changes
print('results of datalad status call:')
dl.status(recursive=True, eval_subdataset_state ='commit', result_renderer ='tailored')

# Set commit message
commitmessage = input("Optionally enter a commit message, and hit return: ")
if not commitmessage:
    print("using date as commit message")
    commitmessage = print("commit on" , datetime.now())

# sync
print("update changes from server")
dl.update(how='merge', recursive=True)
print("saving changes")
dl.save(".", message=commitmessage, recursive=True)
print("pushing saved changes to server")
dl.push(to="origin", recursive=True)

# Set dropping option
q_answer = input("Do you want to drop all files that were uploaded, they will be on the server but not on this computer anymore ? [y/n]")
if q_answer == "y":
    dl.drop(".", recursive=True)
