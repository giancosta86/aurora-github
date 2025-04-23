put lib/**.elv | each {
  |script| elvish -compileonly $script
}