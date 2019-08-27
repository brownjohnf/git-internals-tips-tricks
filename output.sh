#!/bin/bash

set -euo pipefail

function slide() {
  echo "---"
  echo
  echo -n "# "
  echo $@
  echo
}

function code() {
  echo '```'
  $@
  echo '```'
  echo
}

function text() {
  echo $@ | fold -sw 80
  echo
}

function lla() {
  echo '```'
  echo "\$ ls $@"
  ls -lah $@ | awk '{if (NR>1) print $1, $5, $9}'
  echo '```'
  echo
}

function run() {
  echo '```'
  echo "$ $@"
  $@
  echo '```'
  echo
}

slide .git directory
text The files in the .git directory contain all of the contents of the repo
lla .git

slide Content-Addressable
text git is a content-addressable storage system
text This means that you give it some bytes, and it will store them indexed by the checksum of the bytes

slide .git/objects
text Every time you commit, files get stored in .git/objects based on their SHA256
text We can get the hash that git will use when storing a file
run git hash-object example.txt
text and then see it in the .git/objects directory
lla .git/objects
lla .git/objects/8b

slide Reading Objects
text git uses a SHA-1 hashing algorithm, but only after prepending some header metadata
run shasum -a 1 example.txt
text Use plumbing commands to get the contents of the file back out
run xxd .git/objects/8b/04d2f66940d680d9f281235d026dbcbd7edbf8
run git cat-file -p 8b04d2f66940d680d9f281235d026dbcbd7edbf8

slide Commits
text commits are also stored as objects in this blob storage
run git --no-pager log -n 1 fc9cf9e409cb11685d0a90b7e78585ca76723b12
run tree .git/objects/fc
run git cat-file -p fc9cf9e409cb11685d0a90b7e78585ca76723b12


