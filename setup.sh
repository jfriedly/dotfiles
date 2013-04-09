echo "Configuring git"
git config --global user.name "Joel Friedly"
git config --global user.email "joelfriedly@gmail.com"
git config --global github.user jfriedly
git config --global core.editor vim
git config --global color.ui auto
git remote add jfriedly git@github.com:jfriedly/dotfiles.git

CWD=`pwd`

echo "Removing old dotfiles"
rm -f $HOME/.vimrc $HOME/.bashrc $HOME/.bash_aliases.sh $HOME/.tmux.conf $HOME/.gcsms $HOME/.vim/syntax/python.vim
rm -rf $HOME/.bin
rm -f $HOME/.ssh/config $HOME/.ssh/authorized_keys $HOME/.ssh/id_rsa.pub

echo "Linking .vimrc"
ln --symbolic $CWD/.vimrc $HOME/.

echo "Linking Vim Python syntax file"
mkdir -p $HOME/.vim/syntax
ln --symbolic $CWD/.vim/syntax/python.vim $HOME/.vim/syntax/python.vim

echo "Linking .bashrc and .bash_aliases.sh"
ln --symbolic $CWD/.bashrc $HOME/.
ln --symbolic $CWD/.bash_aliases.sh $HOME/.

echo "Linking .tmux.conf"
ln --symbolic $CWD/.tmux.conf $HOME/.

echo "Linking .gcsms"
ln --symbolic $CWD/.gcsms $HOME/.

echo "Creating .bin, linking unlock-ssh-keys.sh and gcsms"
if [ ! -e $HOME/.bin ]
then
    mkdir $HOME/.bin
fi
ln --symbolic $CWD/bin/unlock-ssh-key.sh $HOME/.bin/.
ln --symbolic $CWD/bin/gcsms.py $HOME/.bin/.

echo "Configuring ssh, don't forget to copy over id_rsa"
if [ ! -e $HOME/.ssh ]
then
    mkdir $HOME/.ssh
fi
ln --symbolic $CWD/ssh-config $HOME/.ssh/config
ln --symbolic $CWD/authorized_keys $HOME/.ssh/.
ln --symbolic $CWD/id_rsa.pub $HOME/.ssh/.
