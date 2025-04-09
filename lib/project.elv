use ./projects/loaders

fn detect &descriptor-name=$nil { |directory|
  var project-loader = (loaders:get-for &descriptor-name=$descriptor-name $directory)

  $project-loader $directory

  fail 'NOT IMPLEMENTED YET!'
}

fn enforce-branch-version { |inputs| fail 'NOT IMPLEMENTED YET!' }

