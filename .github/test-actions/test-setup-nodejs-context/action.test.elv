use path
use github.com/giancosta86/ethereal/v1/semver

get-env GITHUB_WORKSPACE |
  path:join (all) tests npm-package |
  cd (all)

fn should-match-version { |version|
  one |
    semver:contains $version |
    should-be $true
}

>> 'The expected NodeJS version' {
  >> 'should now be available' {
    node --version |
      should-match-version (get-env expected-node-version)
  }
}

>> 'The expected pnpm version' {
  >> 'should now be available' {
    pnpm --version |
      should-match-version (get-env expected-pnpm-version)
  }
}

>> 'The project packages' {
  >> 'should be installed' {
    path:join node_modules @giancosta86 typed-env package.json |
      should-be-regular
  }
}