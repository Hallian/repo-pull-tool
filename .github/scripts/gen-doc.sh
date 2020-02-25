#!/usr/bin/env bash

mkdir -p doc/lib
ls -1 lib/*.sh repo-pull-tool.sh | xargs -I {} -n 1 bash -c 'tomdoc.sh --markdown {} > doc/{}.md'

echo "# repo-pull-tool documentation" > doc/README.md
echo -e "\n## Docs by file\n" >> doc/README.md
for file in $(ls -1 lib/*.sh repo-pull-tool.sh | sort); do
  echo "* [$file]($file.md)" >> doc/README.md
done
echo -e "\n## Single page docs\n" >> doc/README.md
tomdoc.sh --markdown lib/*.sh repo-pull-tool.sh >> doc/README.md
