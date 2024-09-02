# tag-and-release

From a Git branch named according to [semver](https://semver.org/), creates a Git tag and a GitHub release.

## Example

```yaml
steps:
  - uses: giancosta86/aurora-github/actions/tag-and-release
```

## Requirements

The same ones discussed for [detect-branch-version](../detect-branch-version/README.md).

## Inputs

|      Name       |    Type     |               Description                | Default value |
| :-------------: | :---------: | :--------------------------------------: | :-----------: |
|  `draft-only`   | **boolean** |          Only draft the release          |   **false**   |
| `delete-branch` | **boolean** | Delete the branch after creating the tag |   **true**    |
|     `shell`     | **string**  |      The shell used to run commands      |   **bash**    |

## Further references

- [aurora-github](../../README.md)
