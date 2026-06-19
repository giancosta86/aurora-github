use ./input

fn main {
  if (not (has-external wasm-pack)) {
    var version = (input:string version)

    echo 🌐 Installing wasm-pack $version...

    npm install -g 'wasm-pack@'$version

    echo ✅ wasm-pack installed!
  }
}
