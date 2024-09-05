# tag-and-release

Creates a Git tag and a GitHub release, from a Git branch named according to [semver](https://semver.org/); by default, it also deletes the current branch _before_ creating the tag.

## Example

```yaml
steps:
  - uses: giancosta86/aurora-github/actions/tag-and-release@v2
```

## Requirements

- the ones discussed for [detect-branch-version](../detect-branch-version/README.md).

- this action requires **read/write** permissions on the repository

## Inputs

|      Name       |    Type     |               Description                | Default value |
| :-------------: | :---------: | :--------------------------------------: | :-----------: |
|  `draft-only`   | **boolean** |          Only draft the release          |   **false**   |
| `delete-branch` | **boolean** | Delete the branch after creating the tag |   **true**    |
|     `shell`     | **string**  |      The shell used to run commands      |   **bash**    |

## Further references

- [detect-branch-version](../detect-branch-version/README.md)

- [aurora-github](../../README.md)
