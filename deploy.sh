#!/usr/bin/env bash
set -eu
PATH_SITE="${1:-temp}"
IMAGE_DIR="images"

if [[ ! -d $PATH_SITE ]]; then
  echo "Create $PATH_SITE"
  mkdir -p $PATH_SITE
fi
INDEX="$PATH_SITE/index.md"

# Generate index.md
cat > $INDEX <<EOF
---
title: 立法技术规范
layout: default
---

EOF

for f in *.md; do
  [ "$f" = "README.md" ] && continue
  [ "$f" = "index.md" ] && continue

  name="${f%.md}"
  echo "- [$name]($f)" >> $INDEX

  cat> $PATH_SITE/$f <<EOF
---
title: $name
layout: default
---

<details>
<summary>目录（点击展开/折叠）</summary>
<div markdown="1">

* TOC
{:toc}

</div>
</details>
EOF

  cat "$f" >> "$PATH_SITE/$f"
done

if [[ -d $IMAGE_DIR ]]; then
  cp -r $IMAGE_DIR $PATH_SITE/
fi
