fn get-full-name {
  get-env GITHUB_REPOSITORY
}

fn get-changelog-url { |base-reference tag|
  put 'https://github.com/'(get-full-name)'/compare/'$base-reference'..'$tag
}