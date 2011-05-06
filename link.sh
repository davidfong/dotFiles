#!/bin/bash
pushd ~
rm .vim
ln -sf  ~/dotFiles/vim .vim
ln -sf ~/dotFiles/tmux.conf .tmux.conf
ln -sf ~/dotFiles/bashrc .bashrc.git
unamestr=`uname`
if [[ "$unamestr" == 'Darwin' ]]; then
  bashfilename='.bash_profile'
elif [[ "$unamestr" == 'Linux' ]]; then
  bashfilename='.bashrc'
fi
# remove source line if it exist
cp $bashfilename $bashfilename.bak
cat $bashfilename.bak | sed '/bashrc.git/d' > $bashfilename
# add source line
echo "source .bashrc.git" >> $bashfilename
popd
