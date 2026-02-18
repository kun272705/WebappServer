#!/usr/bin/env bash

set -euo pipefail

source .builder.sh

npm install

mkdir -p tgt/

for item in src/pub/res/*; do

  copy_item "$item" "tgt/pub/${item##*/}"
done

for item in src/pub/lib.*/*; do

  copy_item "$item" "tgt/pub/lib/${item##*/}"
done

for dir in src/pub/*/; do
 
  item="${dir//.//}"
  item="${item%/}"

  name="${item##*/}"

  if [ -f "$dir$name.java" ]; then

    build_html "$dir$name.html" "tgt/pub/${item#src/pub/}.html"

    build_css "$dir$name.css" "tgt/pub/${item#src/pub/}.css"

    build_js "$dir$name.js" "tgt/pub/${item#src/pub/}.js"

    build_java "$dir$name.java" "tgt/pub/${item#src/pub/}.jar"
  fi
done

echo -e "\nDone"
