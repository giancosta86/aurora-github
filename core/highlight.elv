fn stream { |format|
  if (has-external pygmentize) {
    pygmentize -l $format
  } else {
    only-bytes
  }
}

fn file { |path format|
  to-lines < $path |
    stream $format
}