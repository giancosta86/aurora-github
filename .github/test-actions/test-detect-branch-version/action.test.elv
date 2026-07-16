>> 'Action outputs' {
  >> 'branch' {
    get-env branch |
      should-not-be-empty
  }

  >> 'version' {
    get-env version |
      should-not-be-empty
  }

  >> 'escaped version' {
    get-env escaped-version |
      should-contain \.
  }

  >> 'major component' {
    get-env version |
      should-start-with (get-env major)
  }
}