use os
use ./input
use ../std-err
use ../velvet

var -verification-script = verify.elv

fn main {
  if (os:is-regular $-verification-script) {
    std-err:echo 📜 Verification script found! Now running it...

    elvish $-verification-script
  } else {
    var velvet-version = (input:string velvet-version)

    std-err:echo 🐞 Running Velvet $velvet-version...

    velvet:run-flawless $velvet-version
  }
}