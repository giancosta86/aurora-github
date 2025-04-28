fn write { |target-channel key value|
  echo $key'='(coalesce $value '') >> $target-channel
}

fn map { |target-channel source-map|
  keys $source-map | each { |key|
    write $target-channel $key $source-map[$key]
  }
}