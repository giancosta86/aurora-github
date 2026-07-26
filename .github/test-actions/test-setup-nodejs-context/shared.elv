use re

fn get-version-regex { |version|
  re:quote $version |
    put '\bv?'(all)'\b'
}