## vim config for front-end web developer

  - less highlight https://github.com/groenewege/vim-less
  - css color https://github.com/skammer/vim-css-color
  - css3 sytax https://github.com/hail2u/vim-css3-syntax
  - html5 sytax https://github.com/othree/html5.vim
  - zencoding https://github.com/mattn/zencoding-vim
  - jade highlight https://github.com/digitaltoad/vim-jade
  - neocomplcache https://github.com/Shougo/neocomplcache
  - jslint https://github.com/skammer/vim-css-color

## Install
装好Vim后

````sh
cd ~
git clone https://github.com/maxbbn/vim .vim
ln .vim/\_vim .vim
cd .vim
git submodule init
git submodule update
````

可能还需要装一些第三方包，比如ctags jslint;
可以去看下下面的库

## pathgen
https://github.com/tpope/vim-pathogen
