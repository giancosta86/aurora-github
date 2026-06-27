use str

fn get-full-name {
  get-env GITHUB_REPOSITORY
}

fn get-name {
  get-full-name |
    str:split / (all) |
    drop 1
}

fn get-changelog-url { |base-reference tag|
  put 'https://github.com/'(get-full-name)'/compare/'$base-reference'..'$tag
}