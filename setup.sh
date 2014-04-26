echo "Configuring git"
git config --global user.name "Joel Friedly"
git config --global user.email "joelfriedly@gmail.com"
git config --global github.user jfriedly
git config --global core.editor vim
git config --global color.ui auto

# git aliases
git config --global alias.s status
git config --global alias.f fetch
git config --global alias.fo "fetch origin"
git config --global alias.c commit
git config --global alias.a add
git config --global alias.r rebase
git config --global alias.m merge
git config --global alias.mom "merge origin/master"
git config --global alias.ck checkout
git config --global alias.ckb "checkout -b"
git config --global alias.p push
git config --global alias.pom "push origin master"

export REPO_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $REPO_DIR
git remote add jfriedly git@github.com:jfriedly/dotfiles.git

REPO_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "Removing old dotfiles"
rm -f $HOME/.vimrc $HOME/.bashrc $HOME/.bash_aliases.sh $HOME/.tmux.conf $HOME/.gcsms $HOME/.pylintrc
rm -f $HOME/.vim/syntax/python.vim
rm -f $HOME/.bin/unlock-ssh-key.sh $HOME/.bin/gcsms.py $HOME/.bin/pianopy.py
rm -f $HOME/.ssh/config $HOME/.ssh/authorized_keys $HOME/.ssh/id_rsa.pub
rm -f $HOME/.rst2pdf/styles/helvetica-titles-serif-regular
rm -f $HOME/.openrc

echo "Linking .vimrc"
ln --symbolic $REPO_DIR/.vimrc $HOME/.

echo "Linking Vim Python syntax file and .pylintrc"
mkdir -p $HOME/.vim/syntax
ln --symbolic $REPO_DIR/.vim/syntax/python.vim $HOME/.vim/syntax/.
ln --symbolic $REPO_DIR/.pylintrc $HOME/.

echo "Linking .bashrc and .bash_aliases.sh"
ln --symbolic $REPO_DIR/.bashrc $HOME/.
ln --symbolic $REPO_DIR/.bash_aliases.sh $HOME/.
source $HOME/.bashrc
source $HOME/.bash_aliases

echo "Linking .tmux.conf"
ln --symbolic $REPO_DIR/.tmux.conf $HOME/.

echo "Linking .gcsms"
ln --symbolic $REPO_DIR/.gcsms $HOME/.

echo "Creating .bin, linking unlock-ssh-keys.sh and gcsms"
mkdir -p $HOME/.bin
ln --symbolic $REPO_DIR/bin/unlock-ssh-key.sh $HOME/.bin/.
ln --symbolic $REPO_DIR/bin/gcsms.py $HOME/.bin/.
ln --symbolic $REPO_DIR/bin/pianopy.py $HOME/.bin/.

echo "Configuring ssh, don't forget to copy over id_rsa"
mkdir -p $HOME/.ssh
ln --symbolic $REPO_DIR/ssh/config $HOME/.ssh/.
ln --symbolic $REPO_DIR/ssh/authorized_keys $HOME/.ssh/.
ln --symbolic $REPO_DIR/ssh/id_rsa.pub $HOME/.ssh/.

echo "Creating ~/.rst2pdf, linking in my stylesheets"
# use these by passing -s /path/to/stylesheet to rst2pdf
mkdir -p $HOME/.rst2pdf/styles
ln --symbolic $REPO_DIR/rst2pdf/helvetica-titles-serif-regular $HOME/.rst2pdf/styles/.
ln --symbolic $HOME/git/dotfiles/rst2pdf/marginless $HOME/.rst2pdf/styles/.

echo "Creating ~/.openrc, sourcing it"
ln --symbolic $REPO_DIR/.openrc $HOME/.
source $HOME/.openrc
