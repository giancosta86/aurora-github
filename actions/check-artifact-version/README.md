# check-artifact-version

Ensures the artifact version - expressed according to the project technology - matches the current branch version, detected by [detect-branch-version](../detect-branch-version/README.md); if the project tech cannot be detected via [detect-project-tech](../detect-project-tech/README.md), the action fails.

## Example

```yaml
steps:
  - uses: giancosta86/aurora-github/actions/check-artifact-version@v4
```

**Please, note:** this action is automatically run by [verify-rust-crate](../verify-rust-crate/README.md) and [verify-npm-package](../verify-npm-package/README.md) by default.

## Requirements

- The ones described for [detect-project-tech](../detect-project-tech/README.md)

- The ones described for [detect-branch-version](../detect-branch-version/README.md)

## Inputs

|        Name         |    Type    |          Description           | Default value |
| :-----------------: | :--------: | :----------------------------: | :-----------: |
| `project-directory` | **string** |     The project directory      |     **.**     |
|       `shell`       | **string** | The shell used to run commands |   **bash**    |

## Further references

- [detect-project-tech](../detect-project-tech/README.md)

- [detect-branch-version](../detect-branch-version/README.md)

- [verify-rust-crate](../verify-rust-crate/README.md)

- [verify-npm-package](../verify-npm-package/README.md)

- [aurora-github](../../README.md)
