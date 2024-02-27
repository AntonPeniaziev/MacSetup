# ------- Homebrew -------
# Check for Homebrew,
# Install if we don't have it

osascript -e 'tell app "System Events" to tell appearance preferences to set dark mode to true'

if test ! $(which brew); then
  echo "Installing homebrew... 🍺"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/$user/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Update homebrew recipes
echo "Updating homebrew... 🆕"
brew update
# ------- Homebrew -------

# ------- Git -------
echo "Installing Github CLI... 🦸‍♂️"
brew install gh

gh auth login

# ------- Terminal Setup -------

#Install Zsh & Oh My Zsh
echo "Installing Oh My ZSH... 😱"
curl -L http://install.ohmyz.sh | sh

echo "Setting up Oh My Zsh theme... 🎨"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
# open ~/.zshrc
echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc

echo "Add some auto suggestions... 👨‍🚒"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
# open ~/.zshrc
# read -p "Please add zsh-autosuggestions & zsh-syntax-highlighting to your Plugins! e. g. plugins=(... zsh-autosuggestions zsh-syntax-highlighting) (WITHOUT comma) ✍️ and then press Enter!"
 
echo 'plugins=(zsh-autosuggestions zsh-syntax-highlighting)' >>~/.zshrc

echo "Setting ZSH as shell... 💻"
chsh -s /usr/local/bin/zshd

# ------- Terminal Setup -------

echo "Cleaning up brew 🧹"
brew cleanup

# ------- Apps -------
apps=(
  alfred
  bettertouchtool
  bitwarden
  google-chrome
  iterm2
  sourcetree
  spotify
  docker
  pycharm-ce
  intellij-idea-ce
  miniconda
  poetry
  postman
  zoom
  whatsapp
  sublime-text
  vlc
  slack
  discord
  dbeaver-community
)

echo "installing python base envs ⏳"

cat << 'EOF' >> ~/.zshrc
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="\$('/usr/local/Caskroom/miniconda/base/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ \$? -eq 0 ]; then
    eval "\$__conda_setup"
else
    if [ -f "/usr/local/Caskroom/miniconda/base/etc/profile.d/conda.sh" ]; then
        . "/usr/local/Caskroom/miniconda/base/etc/profile.d/conda.sh"
    else
        export PATH="/usr/local/Caskroom/miniconda/base/bin:\$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
EOF


conda create -n py38 python=3.8
conda create -n py311 python=3.11

# Install apps to /Applications
# Default is: /Users/$user/Applications
echo "installing apps with Cask... ⏳"
brew install ${apps[@]}
brew install powerlevel10k

echo "source $(brew --prefix)/share/powerlevel10k/powerlevel10k.zsh-theme" >>~/.zshrc


brew cleanup
# ------- Apps -------

# ------- Mac Settings -------
echo "Setting some Mac settings... ⚙️"

#"Automatically quit printer app once the print jobs complete 🖨"
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

#"Showing icons for hard drives, servers, and removable media on the desktop ℹ️"
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true

#"Enabling UTF-8 ONLY in Terminal.app and setting the Pro theme by default 💻"
defaults write com.apple.terminal StringEncodings -array 4
defaults write com.apple.Terminal "Default Window Settings" -string "Pro"
defaults write com.apple.Terminal "Startup Window Settings" -string "Pro"

#"Preventing Time Machine from prompting to use new hard drives as backup volume 😫"
# defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

#"Setting screenshot format to PNG 📸"
# defaults write com.apple.screencapture type -string "png"


defaults write com.apple.dock magnification -bool false
defaults write com.apple.dock tilesize -int 38
killall Dock

# ------- Mac Settings -------

killall Finder



