# check-action-references

Prevents cross-branch `uses:` directives to **GitHub** actions residing below the same root directory.

## Example

```yaml
steps:
  - uses: giancosta86/aurora-github/actions/check-action-references@v4
```

## How it works

When creating actions in a repository acting as a library for GitHub Actions, you could need to reference one action from another: this action ensures that all the above local `@` tags only reference actions on the current branch.

## Requirements

- The check is only performed on [composite GitHub actions](https://docs.github.com/en/actions/sharing-automations/creating-actions/creating-a-composite-action), written in files having `.yml` extension and residing below the given `actions-directory`.

## Inputs 📥

|        Name         |    Type    |                      Description                      | Default value |
| :-----------------: | :--------: | :---------------------------------------------------: | :-----------: |
| `actions-directory` | **string** | The root of the directory tree containing the actions | **./actions** |
|       `shell`       | **string** |            The shell used to run commands             |   **bash**    |

## Further references

- [Composite GitHub actions](https://docs.github.com/en/actions/sharing-automations/creating-actions/creating-a-composite-action)

- [aurora-github](../../README.md)
