use path

>> 'The expected NodeJS version' {
  >> 'should not be already installed' {
    if (has-external node) {
      node --version |
        should-not-match-regex '\bv?'(get-env expected-node-version)'\b'
    }
  }
}

>> 'The expected pnpm version' {
  >> 'should not be already installed' {
    if (has-external pnpm) {
      pnpm --version |
        should-not-match-regex '\bv?'(get-env expected-pnpm-version)'\b'
    }
  }
}