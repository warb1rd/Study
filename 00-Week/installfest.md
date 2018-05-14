# WDI Installfest (Mac)

## Before You Begin

1. Please check your version of OS X before your begin. (Click the Apple icon in the upper left corner and choose *About this Mac*). The following installation procedures should work for Mavericks or Yosemite. If you are running a different version of OS X, please let an instructor know.
2. Don't type any commands that begin with the word `sudo` unless they appear in this document or an instructor tells you to do so.
3. If you run into trouble or error messages that you aren't sure how to fix, grab an instructor.


## XCode Command Line Tools

In Terminal:

```
xcode-select --install
```

## Homebrew

### Install Homebrew

In Terminal:

```
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

### Brew Doctor

In Terminal:

```
brew doctor
```

- See what the doctor says. You may need to edit your ~/.bash_profile or make other adjustments. If you're not sure how to handle the output, flag down an instructor!


## rbenv, Ruby, and Rails

### Install RBENV

In Terminal:

```
brew update
```

Then, we'll use Homebrew to install rbenv:

```
brew install rbenv ruby-build
```

Next, we'll make sure your $PATH has access to the rbenv command-line utility:

```
echo 'export PATH="$HOME/.rbenv/shims:$PATH"' >> ~/.bash_profile
```

Then, we'll enable shims and autocompletion:

```
echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
```

After that, reload your bash profile:

```
source ~/.bash_profile
```

### Install Ruby 2.4.2

In Terminal:

```
rbenv install 2.4.2
```

This will take a while. Don't worry if it's more than 5 minutes and it looks like nothing has happened.

#### Set Ruby 2.4.2 as the Default

In Terminal:

```
rbenv global 2.4.2
```

#### Rehash to install shims

In Terminal:

```
rbenv rehash
```

### Rails

#### Install Rails and then rehash

In Terminal:

```
gem install rails --no-ri --no-rdoc
```

Once that's done, type:

```
rbenv rehash
```

### Verify the correct version and location of your Ruby and Rails installations

In Terminal:

```
ruby -v
```

You should see Ruby 2.4.2

Next, type:

```
which ruby
```

You should see `/Users/usernamehere/.rbenv/shims/ruby`

Next, type:

```
rails -v
```

You should see Rails 5.*.*

Next, type:

```
which rails
```

You should see `/Users/usernamehere/.rbenv/shims/rails`

If any of your information looks different, please find an instructor!

## Update Paths

In Terminal:

```
sudo nano /etc/paths
```

Enter your password when prompted.

> **PRO TIP:** you won't see your password show up in Terminal as you type it. Just type it in and hit enter.

Now, we will add the path where Homebrew should install software. It is important that files here are executed before the default software installed with your Mac. So, add a line to the top of the file:

```
/usr/local/bin
```

Press control x to exit. Press y enter when prompted to save these changes.

## Git

### Install

In Terminal, install the distributed version control system Git:

```
brew install git
```

Once that install is complete, type:

```
which git
```

You should see `/usr/local/bin/git`

If you see something different, please notify an instructor.

### Git Configuration

In Terminal:

```
git config --global user.name "Your Name"
```

Then, using the same email you used to sign up with Github,

```
git config --global user.email "youremail@whatever.com"
```

Then

```
git config --global credential.helper cache
```

And finally

```
git config --global push.default simple
```



## Install the databases MongoDB and PostgreSQL:

```
brew install mongodb
```

Next, create the directory where our Mongo databases will be stored:

```
mkdir -p /data/db
```

Now, we need to make sure that we have the permissions needed to write data to this directory:

```
sudo chown -R $USER /data
```

## Install the PostgreSQL app

- **Download and install Postgres.app (http://postgresapp.com/).** After running the downloaded file, a Finder window will open. Inside this window, drag the Postgres.app icon into the Applications folder.


## Install the image processing library ImageMagick (used with Paperclip for photo uploads):

```
brew install imagemagick
```

## Install node.js

```
brew install node
```

To make sure that it was installed, run

```
node -v
```

You should see 8.9 or higher



## Visual Studio Code

- **Download and install Visual Studio Code (https://code.visualstudio.com/Download).** After running the downloaded file, follow the instructions.
- **Add Visual Studio Code to your dock.** Press Command-Space to open Spotlight. Type Atom, then drag the Atom icon to the dock at the bottom of your screen. This allows you to easily open Atom.


## MacDown

- Go to https://macdown.uranusjr.com/ and download + install MacDown to view and edit Markdown (.md) files.