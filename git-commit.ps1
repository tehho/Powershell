Param(
  [string]
  [alias("m")]$comment
  )

git add .
git commit -m $comment
git pull
git push
