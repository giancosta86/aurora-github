describe 'Concatenating two strings' {
  it 'should work' {
    var a = 'A'
    var b = 'B'

    put $a''$b |
      should-be 'AB'
  }
}