#!/bin/bash

find -E labs -iregex ".*\.(exs|ex)" -print \
  | grep -v fibonacci/deps \
  | sort \
  | xargs wc -l
