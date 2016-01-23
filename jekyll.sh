export OS=$(lsb_release -si)
if [[ $OS == Arch ]] or [[ $OS == ManjaroLinux ]]; then
  sudo pacman -S rubygems --noconfirm --needed
elif [[ $OS == Fedora ]] or [[ $OS == Korora ]]; then
  sudo dnf install -y ruby
elif [[ $OS == Sabayon ]] or [[ $OS == Spike ]]; then
  sudo equo i dev-ruby/rubygems
elif [[ $OS == antiX ]] or [[ $OS == Debian]] or [[ $OS == LinuxMint ]] or [[ $OS == PCLinuxOS ]] or [[ $OS == Ubuntu ]]; then
  sudo apt-get install -y ruby
elif [[ $OS == Calculate ]] or [[ $OS == Gentoo ]]; then
  sudo emerge dev-ruby/rubygems
elif [[ $OS == Mageia ]] or [[ $OS == OpenMandriva ]]; then
  sudo urpmi ruby-RubyGems
elif [[ $OS == CentOS ]] or [[ $OS == Oracle ]]; then
  sudo yum install -y rubygems
elif [[ $OS == openSUSE ]] or [[ $OS == SLE ]]; then
  sudo zypper in rubygems
fi
gem install bundler
bundle install
