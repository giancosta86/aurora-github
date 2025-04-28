fn parse { |string|
  ==s $string true
}

fn format { |bool-value|
  if (eq $bool-value $true) {
    put true
  } elif (eq $bool-value $false) {
    put false
  } else {
    fail 'Boolean value expected!'
  }
}