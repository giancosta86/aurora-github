# detect-project-tech

Tries to infer the current project tech - and related aspects - from the source files.

## Example

```yaml
steps:
  - id: detector
    uses: giancosta86/aurora-github/actions/detect-project-tech@v4

  - run: |
      projectTech="${{ steps.detector.outputs.project-tech }}"
      projectArtifact="${{ steps.detector.outputs.project-artifact }}"

      echo "Detected project tech: '$projectTech'"
      echo "Detected project artifact: '$projectArtifact'"
```

## Requirements

- a **Rust** crate must have its `Cargo.toml`.

- a **NodeJS** package must have its `package.json`.

## Inputs

|        Name         |    Type    |          Description           | Default value |
| :-----------------: | :--------: | :----------------------------: | :-----------: |
| `project-directory` | **string** |     The project directory      |     **.**     |
|       `shell`       | **string** | The shell used to run commands |   **bash**    |

## Outputs

|         Name          |    Type    |        Description        |  Supported values   |
| :-------------------: | :--------: | :-----------------------: | :-----------------: |
|    `project-tech`     | **string** | The detected project tech | _(see table below)_ |
| `artifact-descriptor` | **string** |  The artifact descriptor  | _(see table below)_ |

### Output values

|   project-tech   | artifact-descriptor |   Supported project types    |
| :--------------: | :-----------------: | :--------------------------: |
|       rust       |     Cargo.toml      | _Rust crate or web assembly_ |
|      nodejs      |    package.json     |       _NodeJS package_       |
| _(empty string)_ |  _(empty string)_   |  _Unsupported project tech_  |

## Further references

- [aurora-github](../../README.md)
