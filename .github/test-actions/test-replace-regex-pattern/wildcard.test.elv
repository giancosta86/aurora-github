cd (get-env temp-dir)

>> 'After replacement via wildcard' {
  >> 'A should revert the previous replacements' {
    to-lines < A.txt |
      should-be 'alpha'
  }

  >> 'B should revert the previous replacements' {
    to-lines < B.txt |
      should-be 'beta'
  }
}