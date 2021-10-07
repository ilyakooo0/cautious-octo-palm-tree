#!/bin/bash

while [[ $# -gt 0 ]]; do
  case $1 in
  --input)
    input=$2
    ;;
  --train_ratio)
    train_ratio=$2
    ;;
  --y_column)
    y_column=$2
    ;;
  *)
    echo "$1 is not an argument"
    exit 1
    ;;
  esac
  shift 2
done

if [ -z "$input" ]; then
  echo "--input not set"
  exit 1
fi
if [ -z "$train_ratio" ]; then
  echo "--train_ratio not set"
  exit 1
fi
if [ -z "$y_column" ]; then
  echo "--y_column not set"
  exit 1
fi

index=$(head -1 "$input" | sed 's/,/\n/g' | nl | awk "\$2 ~ /^$y_column$/ {print \$1}")

if [ -z "$index" ]; then
  echo "$y_column is not a column in the file :("
  exit 1
fi

number_of_lines=$(wc -l <"$input")
train_lines=$(echo "$number_of_lines * $train_ratio / 100" | bc)
test_lines=$(echo "$number_of_lines - $train_lines" | bc)

head -1 "$input" >"train-$input"
head -1 "$input" >"test-$input"

tail -n +2 "$input" | head -n "$train_lines" >>"train-$input"
tail -n +2 "$input" | tail -n "$test_lines" >>"test-$input"
