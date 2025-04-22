#[cfg(test)]
mod tests {
    use std::fs;

    #[test]
    fn generate_file() {
        fs::write("out.txt", "TEST OK").unwrap();
    }
}
