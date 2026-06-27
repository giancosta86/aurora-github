use os
use ./input
use ../velvet

var -verification-script = verify.elv

fn main {
  if (os:is-regular $-verification-script) {
    echo 📜 Verification script found! Now running it...

    elvish $-verification-script
  } else {
    var velvet-version = (input:string velvet-version)

    echo 🐞 Running Velvet $velvet-version...

    velvet:run-flawless $velvet-version
  }
}