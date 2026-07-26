use path

get-env GITHUB_WORKSPACE |
  path:join (all) tests npm-package |
  cd (all)

>> 'The expected NodeJS version' {
  >> 'should now be available' {
    node --version |
      should-match-regex '\bv?'(get-env expected-node-version)'\b'
  }
}

>> 'The expected pnpm version' {
  >> 'should now be available' {
    pnpm --version |
      should-match-regex '\bv?'(get-env expected-pnpm-version)'\b'
  }
}

>> 'The project packages' {
  >> 'should be installed' {
    path:join node_modules @giancosta86 typed-env package.json |
      should-be-regular
  }
}