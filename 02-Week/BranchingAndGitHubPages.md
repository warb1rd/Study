# GitHub Branches

Many software companies will say:

> "Commit often, but don't commit to the `master` branch directly..."

Let's break down what this means and figure this out:

1. Commits are markers for changes to a project. A single commit can include the changes to one file, or many. A change to a file can mean either:
   1. the creation of a file
   2. the editing of a file
   3. the deletion of a file
2. These committed changes are by default recorded on what git calls the `master` branch. So what is a branch and why's it called `master`?
   - A branch can be thought of as a virtual timeline. The commits you make will be added to the timeline of whatever branch you're currently on. The `master` branch is the default branch that comes standard in all git repositories.
   - So creating a new branch off of the master branch, you're essentially creating a virtual timeline that *includes* all of the commits from `master` up until the point you created the new branch. If you're on a newly created branch, subsequent commits will happen on *THAT NEW BRANCH*.
   - So, it's called the `master` branch because all other branches include the commits from this main branch.
   - The branches you create should contain new commits that pertain to one feature for an application. For example, I might create a branch called `footer`, and while I'm on that branch, I'm only working on code pertaining to the footer of the website or web application.
   - When the 'feature' is complete, aka the code for that particular feature is tested, approved, and ready to include in the main timeline (`master`), you can take those new feature-specific commits from the other branch and `merge` them into the master branch.

Here's how we create new branches in git:

The following both creates the new branch AND switches to this new branch. Branch names cannot contain spaces:

```bash
git checkout -b branch-name-here
```

You can at any point check to see which branch you're on with:

```bash
git branch
```

Switching between branches is easy too, just replace `branch-name-here` with the actual name of the branch you want to switch to:

```bash
git checkout branch-name-here
```



## Merging from a feature branch into `master`:

1. From the feature branch, make sure everything has been tested and works to your liking, and check to make sure there's no changes that have yet to be committed:

   ```bash
   git status
   ```

2. Then switch to the master branch, aka the branch you want to bring feature commits INTO:

   ```bash
   git checkout master
   ```

3. Merge all new commits from the feature branch into the `master` branch:

   ```bash
   git merge branch-name-here
   ```

That's it. Assuming there's no merge conflicts (which we'll talk about VERY soon, you should be able to bring feature functionality from dedicated branches into master as you need!)

And when you're done building a feature and merging it into the `master` branch, you can push the updated master branch up to GitHub!

```bash
git push origin master
```



# GitHub pages

Github pages is a way for developers to host or deploy static web pages to the internet, for FREE!

## The process is very simple:

 First, we'll assume that the master branch has all of the commits that make up your app that you want to deploy. From the master branch, create a branch called `gh-pages`:

```bash
git checkout -b gh-pages
```

the name `gh-pages` is IMPORTANT, because GitHub sees it as a keyword, and does a bunch of magic for us as soon as it sees the branch. We just need to push the new gh-pages branch to GitHub:

```bash
git push origin gh-pages
```

This new `gh-pages` branch is a mirror of your master branch since we haven't done and committed any work to it.

After a few moments, you should be able to visit a unique URL in your browser that runs the static HTML/JS/CSS page you've built. The URL is as follows:

https://yourusername.github.io/repository-name

So if your username is 'jackie123' and your repo is called 'game-of-thrones', the url will be:

https://jackie123.github.io/game-of-thrones

That's it!