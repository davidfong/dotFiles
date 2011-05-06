#!/bin/bash
pushd ~
rm .vim
ln -sf  ~/dotFiles/vim .vim
ln -sf ~/dotFiles/tmux.conf .tmux.conf
popd
