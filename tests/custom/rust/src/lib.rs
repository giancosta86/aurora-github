#[cfg(test)]
mod tests {
    use std::fs;

    #[test]
    fn generate_file() {
        fs::write("generated-file.txt", "Rust-generated content").unwrap();
    }
}
