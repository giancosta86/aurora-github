use path
use ./shared

fn should-not-match-version { |version|
  one |
    should-not-match-regex (shared:get-version-regex $version)
}

>> 'The expected NodeJS version' {
  >> 'should not be already installed' {
    if (has-external node) {
      node --version |
        should-not-match-version (get-env expected-node-version)
    }
  }
}

>> 'The expected pnpm version' {
  >> 'should not be already installed' {
    if (has-external pnpm) {
      pnpm --version |
        should-not-match-version (get-env expected-pnpm-version)
    }
  }
}