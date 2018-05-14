# Git Cheatsheet

Git tracks CHANGES to code, not the files themselves

### `git init`
Creates a hidden `.git` folder, turning your directory into a repo.

### `git status`
Lists all files that have been modified since the last commit.

### `git add <file-name>`
Adds a changed file to the 'staging area'.

### `git add -A`
Adds all files that have been modified *within the main folder the git repository is associated with* to the 'staging area'.

### `git add .`
Adds all files that have been modified *in the directory you're currently in* to the 'staging area'.

### `git commit -m 'message goes here, short and sweet'`
Packages all the changes from the staging area into a timeline milestone.

### `git diff`
Shows a detail of what has been changed in each file since the last commit.

### `git log`
Shows a list of all commits

### `git reset --hard <commit id>`
Goes back in time to previous commit - will eliminate any commits that happened after

### `git remote add origin <remote repo url>`
Adds a remote destination that we can push to or pull from (on GitHub).

### `git remote -v`
List available destinations to push to or pull from.

### `git push origin master`
Compares local changes to remote changes, then uploads local changes that the remote doesn't have yet.

### `git clone <remote repo url>`
Creates a directory named after the remote repo and downloads an entire git history to that directory.

### `git checkout -b <name of new branch>`
Creates a new branch, names it, and switches to it.

### `git branch`
List all branches, highlighting the branch you're on.

### `git checkout <branch name>`
Switches you back to whichever branch you indicate. Will show you the last updated code on that branch.

### `git merge <branch name>`
First, make sure you're on the branch that you want ot bring commits into. Then run this command to bring in any commits from another branch that your current branch doesn't have.

### `git checkout -b gh-pages`
Creates a new branch so you can push live through Git Hub
