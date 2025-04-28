use str

fn compute256 { |source|
  to-string $source |
    sha256sum |
    str:split ' ' (all) |
    take 1
}