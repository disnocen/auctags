# Ascending Universal `ctags`

At fist there was `ctags`. Then `e`xtended `ctags`. Then `u`niversal `ctags`. The issue with all of them is that they `recurse` _into_ the directories supplied. What if a function is in a library _outsize_ the directory we are working on? This is standard behavior in C/C++ bu also in Python and Rust. Hence the need for an _ascending_ `ctags`.
