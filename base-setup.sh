#!/bin/bash

sudo pacman -S --noconfirm git base-devel xorg-apps xorg-server xorg-xinit neovim tmux xsel ttf-joypixels wqy-microhei ttf-jetbrains-mono fcitx5-im fcitx5-rime picom ninja ripgrep lazygit

SUCKLESS_DIR=$HOME/suckless
rm -rf $SUCKLESS_DIR
mkdir $SUCKLESS_DIR

git clone https://github.com/tabsp/dwm.git $SUCKLESS_DIR/dwm
git clone https://github.com/tabsp/st.git $SUCKLESS_DIR/st
git clone https://github.com/tabsp/dmenu.git $SUCKLESS_DIR/dmenu
git clone https://github.com/tabsp/slstatus.git $SUCKLESS_DIR/slstatus

cd $SUCKLESS_DIR/dwm && sudo make clean install
cd $SUCKLESS_DIR/st && sudo make clean install
cd $SUCKLESS_DIR/dmenu && sudo make clean install
cd $SUCKLESS_DIR/slstatus && sudo make clean install

echo "exec slstatus &" >> $HOME/.xinitrc
echo "exec picom &" >> $HOME/.xinitrc
echo "exec fcitx5 &" >> $HOME/.xinitrc
echo "exec dwm" >> $HOME/.xinitrc

cat > $HOME/.pam_environment <<EOF
GTK_IM_MODULE DEFAULT=fcitx
QT_IM_MODULE  DEFAULT=fcitx
XMODIFIERS    DEFAULT=\@im=fcitx
INPUT_METHOD  DEFAULT=fcitx
SDL_IM_MODULE DEFAULT=fcitx
GLFW_IM_MODULE DEFAULT=ibus
EOF

YAY_DIR=/tmp/yay
rm -rf $YAY_DIR
git clone https://aur.archlinux.org/yay.git $YAY_DIR
cd $YAY_DIR
makepkg -si --noconfirm

yay -S --noconfirm nerd-fonts-jetbrains-mono

rm -rf $HOME/dotfiles && git clone https://github.com/tabsp/dotfiles.git $HOME/dotfiles
rm -rf $HOME/.config && ln -s $HOME/dotfiles/.config $HOME/.config
rm -rf $HOME/.zsh && rm -f $HOME/.zshrc && ln -s $HOME/dotfiles/.zsh $HOME/.zsh && ln -s $HOME/dotfiles/.zshrc $HOME/.zshrc
rm -f .tmux.conf && ln -s -f $HOME/dotfiles/.tmux.conf $HOME/.tmux.conf
