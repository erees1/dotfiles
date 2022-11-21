#!/bin/bash
git fetch origin master:master
git branch $1 master 
git checkout $1
