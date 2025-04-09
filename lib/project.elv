use ./projects/loaders

fn detect { |directory &descriptor-name=$nil|
  var project-loader = (loaders:get-for &descriptor-name=$descriptor-name $directory)

  $project-loader $directory
}
