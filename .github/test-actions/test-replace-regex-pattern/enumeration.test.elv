cd (get-env temp-dir)

>> 'After replacement via enumeration' {
  >> 'A should include the replacements' {
    to-lines < A.txt |
      should-be '*a*lph*a*'
  }

  >> 'B should include the replacements' {
    to-lines < B.txt |
      should-be 'b*e*t*a*'
  }
}