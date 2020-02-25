#!/usr/bin/env bash

mkdir -p docs/lib
ls -1 lib/*.sh repo-pull-tool.sh | xargs -I {} -n 1 bash -c 'tomdoc.sh --markdown {} > docs/{}.md'

echo "# repo-pull-tool documentation" > docs/docs.md
echo -e "\n## Docs by file\n" >> docs/docs.md
for file in $(ls -1 lib/*.sh repo-pull-tool.sh | sort); do
  echo "* [$file]($file.md)" >> docs/docs.md
done
echo -e "\n## Single page docs\n" >> docs/docs.md
tomdoc.sh --markdown lib/*.sh repo-pull-tool.sh >> docs/docs.md
cp docs/docs.md docs/README.md
cp README.md docs/index.md
