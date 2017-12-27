# ObjectCreator

A command-line utility to convert json payloads into Codable-conforming Swift structs.

## Installation

Installation is simple, just clone the repo, `cd` into the directory, and run the `install.sh` script. 

## Usage

```
$ codable --help

Usage:

    $ codable <source> <name>

Arguments:

    source - file path of json file, relative to the current directory
    name - name of top-level object

Options:
    --dir [default: export] - Output directory to write resulting files
    --print [default: false] - Print resulting file contents to the console
    --debug [default: false] - Print debug information to the console
```