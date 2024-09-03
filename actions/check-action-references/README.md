# check-action-references

Prevents `uses:` directives from referencing other GitHub actions, within the same repository, not on the _default_ branch.

## Example

```yaml
steps:
  - uses: giancosta86/aurora-github/actions/check-action-references
```

## How it works

When developing new actions, you could need to reference one from another; since both actions temporarily reside in a new Git branch, you'll need `@bX.Y.Z` in the `use:` directive.

This action is designed for pull request validation workflows - as it ensures that all the above `@` tags have been removed between actions belonging to the same repository: only references to the default branch are allowed.

## Requirements

- The check is only performed on [composite GitHub actions](https://docs.github.com/en/actions/sharing-automations/creating-actions/creating-a-composite-action), written in files having `.yml` extension.

## Inputs

|        Name         |    Type    |          Description           | Default value |
| :-----------------: | :--------: | :----------------------------: | :-----------: |
| `project-directory` | **string** |     The project directory      |     **.**     |
|       `shell`       | **string** | The shell used to run commands |   **bash**    |

## Further references

- [Composite GitHub actions](https://docs.github.com/en/actions/sharing-automations/creating-actions/creating-a-composite-action)

- [aurora-github](../../README.md)
