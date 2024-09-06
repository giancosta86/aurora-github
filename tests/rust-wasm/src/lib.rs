use wasm_bindgen::prelude::*;


#[wasm_bindgen]
pub fn add_ninety(x: i32) -> i32 {  
  x + 90
}


#[cfg(test)]
mod tests {
  use super::*;

  #[test]
  pub fn unit_test_add_ninety() {
    let result = add_ninety(8);

    assert_eq!(result, 98);
  }
}