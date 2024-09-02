# check-artifact-version

Ensures the artifact version - expressed according to the project technology - matches the current branch version, as described in [detect-branch-version](../detect-branch-version/README.md); if the project type cannot be detected, the action crashes the workflow.

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

- [aurora-github](../../README.md)
