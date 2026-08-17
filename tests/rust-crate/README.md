Let's test a Rust snippet:

```rust
use std::error::Error;
use rust_crate::add;

fn main() -> Result<(), Box<dyn Error>> {
    let result = add(90, 2);

    assert_eq!(result, 92);

    Ok(())
}
```

Just a TypeScript example, which should not be extracted:

```typescript
Not Rust code
```

Another Rust example:

```rust
use std::error::Error;
use rust_crate::add;

fn main() -> Result<(), Box<dyn Error>> {
    let result = add(90, 5);

    assert_eq!(result, 95);

    Ok(())
}
```

Yet another example:

```rust
use std::error::Error;
use rust_crate::add;

fn main() -> Result<(), Box<dyn Error>> {
    let result = add(90, 8);

    assert_eq!(result, 98);

    Ok(())
}
```
