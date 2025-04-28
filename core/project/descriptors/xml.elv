use str
use github.com/giancosta86/aurora-elvish/highlighting
use github.com/giancosta86/aurora-elvish/resources

var -resources = (resources:for-script (src))

fn read-version { |descriptor-path|
  var python-script-path = ($-resources[get-path] xml-version.py)

  python3 $python-script-path $descriptor-path
}

fn print-content { |descriptor-path|
  cat $descriptor-path | highlighting:highlight xml
}