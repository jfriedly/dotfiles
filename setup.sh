echo "Configuring git"
git config --global user.name "Joel Friedly"
git config --global user.email "joelfriedly@gmail.com"
git config --global github.user jfriedly
git config --global core.editor vim
git config --global color.ui auto
git remote add jfriedly git@github.com:jfriedly/dotfiles.git

echo "Copying over .vimrc"
cp .vimrc $HOME/.

echo "Copying over .bashrc, .bash_aliases.sh, and .inputrc"
cp .bashrc $HOME/.
cp .bash_aliases.sh $HOME/.
cp .inputrc $HOME/.

echo "Copying over .tmux.conf"
cp .tmux.conf $HOME/.

echo "Copying over .gcsms"
cp .gcsms $HOME/.

echo "Creating .bin, copying over unlock-ssh-keys.sh and gcsms"
if [ ! -e $HOME/.bin ]
then
    mkdir $HOME/.bin
fi
cp bin/unlock-ssh-key.sh $HOME/.bin/.
cp bin/gcsms.py $HOME/.bin/.

echo "Configuring ssh, don't forget to copy over id_rsa"
if [ ! -e $HOME/.ssh ]
then
    mkdir $HOME/.ssh
fi
cp ssh-config $HOME/.ssh/config
cp authorized_keys $HOME/.ssh/.
cp id_rsa.pub $HOME/.ssh/.
