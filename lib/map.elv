fn get-value { |map key &default=$nil|
  if (has-key $map $key) {
    put $map[$key]
  } else {
    put $default
  }
}
