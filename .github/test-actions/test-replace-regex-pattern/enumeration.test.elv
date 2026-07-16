cd (get-env temp-dir)

>> 'After replacement via enumeration' {
  >> 'A should include the replacements' {
    slurp < A.txt |
      should-be '*a*lph*a*'
  }

  >> 'B should include the replacements' {
    slurp < B.txt |
      should-be 'b*e*t*a*'
  }
}