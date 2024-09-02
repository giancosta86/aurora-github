# check-artifact-version

Ensures the artifact version - expressed according to the project technology - matches the current branch version, detected by [detect-branch-version](../detect-branch-version/README.md); if the project type cannot be detected via [detect-project-type](../detect-project-type/README.md), the workflow crashes.

## Example

```yaml
steps:
  - uses: giancosta86/aurora-github/actions/check-artifact-version
```

## Requirements

- The ones described for [detect-branch-version](../detect-branch-version/README.md)

- The ones described for [detect-project-type](../detect-project-type/README.md)

## Inputs

|        Name         |    Type    |          Description           | Default value |
| :-----------------: | :--------: | :----------------------------: | :-----------: |
| `project-directory` | **string** |     The project directory      |     **.**     |
|       `shell`       | **string** | The shell used to run commands |   **bash**    |

## Further references

- [detect-branch-version](../detect-branch-version/README.md)
- [aurora-github](../../README.md)
