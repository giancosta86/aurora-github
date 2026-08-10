use path
use github.com/giancosta86/ethereal/v1/semver

fn should-not-match-version { |version|
  one |
    semver:contains $version |
    should-be $false
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