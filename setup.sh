echo "Configuring git"
git config --global user.name "Joel Friedly"
git config --global user.email "joelfriedly@gmail.com"
git config --global github.user jfriedly
git config --global core.editor vim
git config --global color.ui always

echo "Copying over .vimrc"
cp .vimrc $HOME/.

echo "Copying over .bashrc"
cp .bashrc $HOME/.

echo "Creating .bin, coying over unlock-ssh-keys.sh"
if [ ! -e $HOME/.bin ]
then
    mkdir $HOME/.bin
fi
cp bin/unlock-ssh-key.sh $HOME/.bin/.

echo "Configuring ssh, don't forget to copy over id_rsa"
if [ ! -e $HOME/.ssh ]
then
    mkdir $HOME/.ssh
fi
cp ssh-config $HOME/.ssh/config
cp authorized_keys $HOME/.ssh/.
cp id_rsa.pub $HOME/.ssh/.