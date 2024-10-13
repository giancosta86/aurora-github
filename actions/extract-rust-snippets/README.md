# extract-rust-snippets

Extracts **Rust** code snippets from a **Markdown** file to standalone test files.

## Example

```yaml
steps:
  - uses: giancosta86/aurora-github/actions/extract-rust-snippets@v4
```

**Please, note:** this action is automatically run by [verify-rust-crate](../verify-rust-crate/README.md).

## Requirements

- each code snippet must reside in a ` ```rust` code block and must define a `main()`function returning a type supporting`.unwrap()`, such as `Result<(), Box<dyn Error>`:

  ```rust
  //Required imports here
  use std::error::Error;

  fn main() -> Result<(), Box<dyn Error>> {
    //Code with assertions here

    Ok(())
  }
  ```

- the Markdown file must exist, but it is not required to contain code snippets: in this case, no test file will be generated.

## How it works

The action extracts each Rust snippet from the given Markdown file, creating a test file containing:

- the snippet itself

- a standalone test calling the `main()` function provided by the snippet:

  ```rust
  #[test]
  fn run_code_snippet() {
    main().unwrap();
  }
  ```

Each test file has this relative path:

` test-filename-prefix` + `N` + **.rs**

where `N` is the position of the snippet within the Markdown content, starting from **1**.

## Inputs 📥

|          Name          |    Type    |                        Description                         |      Default value      |
| :--------------------: | :--------: | :--------------------------------------------------------: | :---------------------: |
|    `markdown-file`     | **string** | Relative path of the Markdown file containing the snippets |      **README.md**      |
| `test-filename-prefix` | **string** |  Relative path prefix for each generated test source file  | **tests/readme_test\_** |
|  `project-directory`   | **string** |            The directory containing Cargo.toml             |          **.**          |
|        `shell`         | **string** |               The shell used to run commands               |        **bash**         |

## Further references

- [verify-rust-crate](../verify-rust-crate/README.md)

- [aurora-github](../../README.md)
