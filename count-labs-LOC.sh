#!/bin/bash

exclude_dir_and_count_elixir_file_lines() {
  EXCLUDE_DIR=$1
  FOLDER=$2

  find -E ${FOLDER} -iregex ".*\.(exs|ex)" -print \
    | grep -v ${EXCLUDE_DIR} \
    | sort \
    | xargs wc -l
}

count_elixir_files_lines_in() {
  FOLDER=$1

  find -E ${FOLDER} -iregex ".*\.(exs|ex)" \
    | sort \
    | xargs wc -l
}

count_elixir_labs_lines_per_file() {
  exclude_dir_and_count_elixir_file_lines 'fibonacci/deps' 'labs'
}

count_elixir_alchemistcamp_lines_per_file() {
  count_elixir_files_lines_in 'alchemist-camp'
}

echo ''
echo 'labs'
echo '----'
echo ''

count_elixir_labs_lines_per_file

echo ''
echo 'alchemist-camp'
echo '--------------'
echo ''

count_elixir_alchemistcamp_lines_per_file

echo ''

LABS_TOTAL=$(count_elixir_labs_lines_per_file | tail -1 | awk '{print $1}')
ALCHEMISTCAMP_TOTAL=$(count_elixir_alchemistcamp_lines_per_file | tail -1 | awk '{print $1}')

echo "Total of lines: $((LABS_TOTAL + ALCHEMISTCAMP_TOTAL))"
