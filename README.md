myvim
=====

This is my vim-configuration

Setup
=====

1. checkout source
    `$ git clone `https://github.com/apoh/myvim.git ~/.vim`

2. create directory ~/.vim/bundle/
    `$ mkdir ~/.vim/vundle`

3. checkout vundle
    `$ git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle`

4. Link repositorie to ~/.vim, vimrc to ~/.vimrc and gvimrc to ~/.gvimrc
    `$ ln -s ~/.vim/vimrc ~/.vimrc`
    `$ ln -s ~/.vim/gvimrc ~/.gvimrc`

5. Install Bundles
    `$ vim +BundleInstall +qall`
