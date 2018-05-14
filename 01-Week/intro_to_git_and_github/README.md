# Git and GitHub

---
## Learning Objectives | SWBAT...
1. Distinguish between local and remote repositories
2. Explain basic commands like init, add, commit, push, pull, and clone
3. Create, copy, and delete repositories locally or on GitHub
4. Fork and clone remote repositories

---
## Intro to Version Control with Git and GitHub 

### What is Git?
A version control system that tracks changes and keeps the history of all changes to computer files.

The codebase in Git is referred to as a **repository** or **repo** for short.
touch
### What is GitHub?
A hosting services for GitHub repositories

### Local vs Remote Repositories
Git enables version control on your **local** machine. GitHub is a place to host your Git repositories **remotely**

## Using Git

### Git Workflow
Each local repository consists of three "trees":
1. ***Working Directory*** holds the actual files
2. ***Index*** is a staging area
3. ***HEAD*** points to the last commit you've made

![Workflow](http://rogerdudler.github.io/git-guide/img/trees.png)

-img from rogerdudler.github.io/git-guide

### Git File Lifecycle
![Git Lifecycle](https://cloud.githubusercontent.com/assets/40461/8226866/62730b4c-159a-11e5-89cd-20b72ed1de45.png)

- **Untracked** - When a file is "untracked", Git is not "watching" this file. It will not be added in the next commit
- **Staged** - Staged files have been added but not yet committed, but are "on deck" for you rnext commit
- **Unmodified** - The file has already been committed and has not changed since your last commit
- **Modified** - The file has been changed since your last commit and will need to be staged to be included in your next commit

### Git Commands
- init
- add
- commit
- push
- pull
- clone

#### init
`init` is the command used to *initialize* a Git repository

1. Using Terminal, navigate to directory that you want to initialize Git within
2. To check whether there is already initialized: `$ git status`
2. Initialize git with the command `$ git init`
3. The folder will appear empty; `$ ls -A` to see .git (which is a hidden file)

#### add
`add` is the command used to *stage* any changes made within the working directory

1. To see whether you've got files that are *untracked* or *modified*: `$ git status` 

![untracked](https://i.imgur.com/0gZjtiv.png) ![modified](https://i.imgur.com/Ckr1ioH.png)

2. To **add** the changes to the staging area: 
	- `$ git add -A` to stage all changed files within the working directory
	- `$ git add .` to stage new and modified files (but will not delete files)
	- `$ git add <filename>`
	- `$ git add <directory>`

Now these change are staged.If you `$ git status` now, you'll see:

![staged](https://i.imgur.com/2UlosFY.png)

#### commit
`commit` is the command used to apply those changes to your Git history

1. To commit changes: `$ git commit -m 'a message goes here'`

**If you forget to add a message to your commit and you get this message**

<img src="https://i.imgur.com/Huft599.png?1" width="500px">

**you can get out of it by hitting ESC, then ENTER, then typing `:wq`**
**Note: you'll need to try committing the file again**

#### log
`log` is a command used to see a list of the commits made

1. To see your commits: `$ git log`

#### Reverting to a previous commit
- Soft reset - will essentially *uncommit*, and will put the changes back into the staging area
- Hard reset - will revert back to the commit you selected and will disregard any adds/commits that were made after (use with extreme caution)


*If you need to revert back to a previous commit*:

1. Check the `git log` 
2. To do a *soft reset* `$ git reset --soft <commit id>
3. To do a *hard reset* `$ git reset --hard <commit id>

## Using GitHub

### Creating New Remote Repositories
Whether you want to start a brand new repo or you have a local Git repo that you want to push to GitHub to be stored remotely, you'll start the same way:

1. Log into your GitHub account
2. Create a new repository

![new repo github](https://help.github.com/assets/images/help/repository/repo-create.png)

3. Name your repository

...

#### Creating an Empty Repository for Syncing a Local Repo

1. If you have a local repository that you want to push to GitHub, make sure the "Initialize this repository with a README" is ***unclicked***
2. Click "Create repository"
3. Copy the HTTP link provided in the light blue box
4. In Terminal, navigate to the repository you want to host 
5. Type `git remote add origin <paste URL>`
6. Press **Enter**

Now your local repo is linked to your remote repo!

But it does not sync automatically (see the section on pushing)


#### Creating an Initialized Repository
1. Make sure the "Initialize this repository with a README" is clicked
2. Click "Create Repository"
3. To copy this repository to your local machine, see the section on cloning

### Pushing an Existing Repository to GitHub
If you have made changes to your local repository and you've already created a remote repo for it:

1. `$ git push origin master`
2. Click **Enter**

Note: This will push any *committed* changes. If changes to your files are not *unmodified* in your local repo, they won't push to your remote repo.

### Cloning
Cloning is creating a copy of a remote repository to create a local copy on your own computer and enabling you to sync between the two locations

1. On GitHub, navigate to the main page of the repository you want to fork
2. Under the repository name, click the **Clone or download** button
3. In the **Clone with HTTPS** box, copy the link provided
4. In Terminal, navigate to the directory you want to clone the repo to
5. Type `git clone <paste URL here>`
6. Press **Enter**

### What is Forking?
A fork is a copy of a repository. Forking allows you to freely experiment without affecting the original project

1. On GitHub, navigate to the main page of the repository you want to fork
2. Click Fork
3. Navigate to your own GitHub repositories to see it there


### What is a Pull Request?
When you want to propose a change to a repository (the original project) that you have forked, you can issue a pull request. 


For slides, click [here](https://presentations.generalassemb.ly/966227f368120c870d34a314f3dfad25#/)
