# `auctags` for Rust

```
rust_auctags/
|-- README.md
|-- rust.ctags
|-- rust_auctags.sh
```

The `rust_auctags.sh` script works for Rust project. Tested only for those projects that use Cargo. You should run the script from the directory with the `Cargo.toml` file. By design it creates a `tags` file in the root directory of the Cargo project, so all files should be opened from there.

It is highly recommended to have a file similar to the `rust.ctags` one in the appropriate directory. the main reason for this is to `exclude` directories and files not needed, such as `.git` directory. This will make the process fast even on small CPUs
