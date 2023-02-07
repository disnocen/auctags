# `auctags` for Python3

```
python3_auctags
|-- README.md
|-- py_auctags.sh
|-- python3.ctags
```


The `py_auctags.sh` script works for python3 projects. toml` file. By design it creates a `tags` file in the root directory of the `main.py` file, so all files should be opened from there.

It is highly recommended to have a file similar to the `python3.ctags` one in the appropriate directory. the main reason for this is to `exclude` directories and files not needed, such as `.git` directory. This will make the process fast even on small CPUs
