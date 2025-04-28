use ./project/loader

fn detect { |&descriptor-name=$nil|
  loader:load &descriptor-name=$descriptor-name
}
