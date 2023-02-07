# Ascending Universal `ctags`

At fist there was `ctags`. Then `e`xtended `ctags`. Then `u`niversal `ctags`. The issue with all of them is that they `recurse` _into_ the directories supplied. What if a function is in a library _outsize_ the directory we are working on? This is standard behavior in C/C++ but also in Python and Rust. Hence the need for an _ascending_ `ctags`.

This has been built with `vi`/`vim`/`nvim` in mind. use the scripts, put them in a directory in `$PATH` and add those lines in your `.vimrc` or `init.vim`:

```vimscript
autocmd FileType rust nnoremap <leader>ct :w<CR>:!rust_auctags.sh<CR><CR>
autocmd FileType python nnoremap <leader>ct :w<CR>:!py_auctags.sh<CR><CR>
```
