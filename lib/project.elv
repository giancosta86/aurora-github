use ./projects/loader

fn detect { |directory &descriptor-name=$nil|
  var project-loader = (loader:get-for &descriptor-name=$descriptor-name $directory)

  $project-loader $directory
}
