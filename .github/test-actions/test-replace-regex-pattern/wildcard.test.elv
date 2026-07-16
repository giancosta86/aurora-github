cd (get-env temp-dir)

>> 'After replacement via wildcard' {
  >> 'A should revert the previous replacements' {
    slurp < A.txt |
      should-be alpha
  }

  >> 'B should revert the previous replacements' {
    slurp < B.txt |
      should-be beta
  }
}