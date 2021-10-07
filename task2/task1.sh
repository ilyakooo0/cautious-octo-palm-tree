#!/bin/bash

workers=4

while [[ $# -gt 0 ]]; do
  case $1 in
  --workers)
    workers=$2
    ;;
  --column)
    column=$2
    ;;
  --out)
    out=$2
    ;;
  --file)
    file=$2
    ;;
  *)
    echo "$1 is not an argument"
    exit 1
    ;;
  esac
  shift 2
done

if [ -z "$out" ]; then
  echo "--out not set"
  exit 1
fi
if [ -z "$column" ]; then
  echo "--column not set"
  exit 1
fi
if [ -z "$file" ]; then
  echo "--file not set"
  exit 1
fi

index=$(head -1 "$file" | sed 's/;/\n/g' | nl | awk "\$2 ~ /^$column$/ {print \$1}")

if [ -z "$index" ]; then
  echo "$column is not a column in the file :("
  exit 1
fi

tail -n +2 "$file" | awk -F ";" "{print \$$index}" | parallel -j "$workers" wget -qP "$out" {}
