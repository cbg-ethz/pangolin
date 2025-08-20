#!/bin/bash

exec sbatch "${@:1:$((${#@}-1))}" < "${@:$((${#@}))}"

# this causes snakemake to pipe the intended comming into sbatch, instead of executing a separate shell script
# circumvents the shell script not being visible yet on target node

