use test_wasm::*;
use wasm_bindgen_test::*;

wasm_bindgen_test::wasm_bindgen_test_configure!(run_in_browser);

#[wasm_bindgen_test]
fn test_add_ninety() {
    let result = add_ninety(2);
    assert_eq!(result, 92);
}
