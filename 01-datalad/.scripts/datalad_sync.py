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
statuslist = dl.status(recursive=True, eval_subdataset_state ='commit', result_renderer ='tailored')

# get data from datalad status, where state was not clean, and print each element in one row:
statuslist3 = []
for v in statuslist:
  if v['state']!="clean": 
    statuslist3 += [v['path']]


if len(statuslist3) > 0:
  # Set commit message
  commitmessage = input("Optionally enter a commit message, and hit return: ")
  if not commitmessage:
    print("using date as commit message")
    commitmessage = "commit on " + datetime.now().strftime("%B %d, %Y")
  # sync
  print("saving changes")
  dl.save(".", message=commitmessage, recursive=True)
  


print("update changes from server")
dl.update(how='merge', recursive=True)

print("pushing saved changes to server")
dl.push(to="origin", recursive=True)

# Set dropping option
print("list of files uploaded (both in git and git-annex):")

for v in statuslist3:
  print(v)


q_answer = input("Do you want to erase (from this computer) all the big files that were uploaded just now, they will be on the server, you can downlaod them with `datalad get <path-to-file>` ? [y/n]")
if q_answer == "y":
  print("The code tries also to drop files that cannot be dropped and this may gives a warning message.")
  for v in statuslist3:
    dl.drop(print(v), recursive=True)

q_answer = input("Do you want to drop all big files, they will be on the server but not on this computer anymore ? [y/n]")
if q_answer == "y":
    dl.drop(".", recursive=True)
