Let's test a Rust snippet:

```rust
use std::error::Error;
use rust_crate::*;

fn main() -> Result<(), Box<dyn Error>> {
  let result = add(90, 8);

  assert_eq!(result, 98);

  Ok(())
}
```
