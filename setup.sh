 
export REPO_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "Removing old dotfiles"
rm -f $HOME/.vimrc $HOME/.bashrc $HOME/.bash_aliases.sh $HOME/.tmux.conf $HOME/.gcsms $HOME/.pylintrc
rm -f $HOME/.vim/syntax/python.vim
rm -f $HOME/.bin/unlock-ssh-key.sh $HOME/.bin/gcsms.py $HOME/.bin/pianopy.py
rm -f $HOME/.ssh/config $HOME/.ssh/authorized_keys $HOME/.ssh/id_rsa.pub
rm -f $HOME/.rst2pdf/styles/helvetica-titles-serif-regular
rm -f $HOME/.rst2pdf/styles/marginless
rm -f $HOME/.openrc
rm -f $HOME/.gitconfig
rm -f $HOME/.zshrc

echo "Configuring git"
cd $REPO_DIR
git remote add jfriedly git@github.com:jfriedly/dotfiles.git
ln -s $REPO_DIR/.gitconfig $HOME/.

echo "Linking .vimrc"
ln -s $REPO_DIR/.vimrc $HOME/.

echo "Linking Vim Python syntax file and .pylintrc"
mkdir -p $HOME/.vim/syntax
ln -s $REPO_DIR/.vim/syntax/python.vim $HOME/.vim/syntax/.
ln -s $REPO_DIR/.pylintrc $HOME/.

echo "Linking .bashrc and .bash_aliases.sh"
ln -s $REPO_DIR/.bashrc $HOME/.
ln -s $REPO_DIR/.bash_aliases.sh $HOME/.
source $HOME/.bashrc
source $HOME/.bash_aliases.sh

echo "Linking .tmux.conf"
ln -s $REPO_DIR/.tmux.conf $HOME/.

echo "Linking .gcsms"
ln -s $REPO_DIR/.gcsms $HOME/.

echo "Linking .zshrc"
ln -s $REPO_DIR/.zshrc $HOME/.

echo "Creating .bin, linking unlock-ssh-keys.sh and gcsms"
mkdir -p $HOME/.bin
ln -s $REPO_DIR/bin/unlock-ssh-key.sh $HOME/.bin/.
ln -s $REPO_DIR/bin/gcsms.py $HOME/.bin/.
ln -s $REPO_DIR/bin/pianopy.py $HOME/.bin/.

echo "Configuring ssh, don't forget to copy over id_rsa"
mkdir -p $HOME/.ssh
ln -s $REPO_DIR/ssh/config $HOME/.ssh/.
ln -s $REPO_DIR/ssh/authorized_keys $HOME/.ssh/.
ln -s $REPO_DIR/ssh/id_rsa.pub $HOME/.ssh/.

echo "Creating ~/.rst2pdf, linking in my stylesheets"
# use these by passing -s /path/to/stylesheet to rst2pdf
mkdir -p $HOME/.rst2pdf/styles
ln -s $REPO_DIR/rst2pdf/helvetica-titles-serif-regular $HOME/.rst2pdf/styles/.
ln -s $HOME/git/dotfiles/rst2pdf/marginless $HOME/.rst2pdf/styles/.

echo "Creating ~/.openrc, sourcing it"
ln -s $REPO_DIR/.openrc $HOME/.
source $HOME/.openrc

