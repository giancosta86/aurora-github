use str
use ./lang

fn get-suggested-shell  { |script-path|
  if (str:has-suffix $script-path '.elv') {
    put 'elvish'
    return
  }

  if (str:has-suffix $script-path '.sh') {
    put 'bash'
    return
  }

  fail "Cannot detect a shell for script path: '"$script-path"'"
}

fn run { |script-path @script-args &shell=$nil|
  var actual-shell = (coalesce $shell (get-suggested-shell $script-path))

  (external $actual-shell) $script-path $@script-args
}