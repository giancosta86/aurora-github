# detect-project-type

Tries to infers the current project type from its files; on failure, the output is set to an empty string.

## Example

```yaml
steps:
  - id: detector
    uses: giancosta86/aurora-github/actions/detect-project-type

  - run: |
      type="${{ steps.detector.outputs.type }}"

      echo "Detected project type: '$type'"
```

## Requirements

- a **Rust** crate should have its `Cargo.toml`

- a **NodeJS** package should have its `package.json`

## Inputs

|        Name         |    Type    |              Description              | Default value |
| :-----------------: | :--------: | :-----------------------------------: | :-----------: |
| `project-directory` | **string** | The directory containing `Cargo.toml` |     **.**     |
|       `shell`       | **string** |    The shell used to run commands     |   **bash**    |

## Outputs

|  Name  |    Type    |        Description        |            Example            |
| :----: | :--------: | :-----------------------: | :---------------------------: |
| `type` | **string** | The detected project type | **rust**, **nodejs**, (empty) |

## Further references

- [aurora-github](../../README.md)
