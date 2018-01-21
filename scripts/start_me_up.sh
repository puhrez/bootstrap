ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# set up virtualenvwrapper folder
mkdir -p ~/envs

# GNU utils that come iwth OS X are outdated
brew install coreutils

# the essentials
brew install python3
brew install python
brew install git
brew install tmux
brew install vcprompt
brew install tree
brew install grip
brew install caskroom/cask/brew-cask
pip install virtualenv virtualenvwrapper
pip3 install ipython


#the nice extras
brew cask install virtualbox
brew cask install slack


# health check!
brew doctor
