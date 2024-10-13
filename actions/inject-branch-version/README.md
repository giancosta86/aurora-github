# inject-branch-version

Injects into a descriptor the version detected from the current **Git** branch.

## Example

```yaml
steps:
  - uses: giancosta86/aurora-github/actions/inject-branch-version@v4
```

## Requirements

- The artifact file should contain at least one occurrence of `0.0.0`: they will all be replaced by the version detected from the current Git branch; however, the action won't fail if there are no occurrences.

- The ones described for [detect-branch-version](../detect-branch-version/README.md).

- If `artifact-descriptor` is missing, the requirements for [detect-project-tech](../detect-project-tech/README.md) apply.

## Inputs 📥

|         Name          |    Type    |               Description                |        Default value        |
| :-------------------: | :--------: | :--------------------------------------: | :-------------------------: |
| `artifact-descriptor` | **string** | Relative path to the artifact descriptor | _(depends on project tech)_ |
|  `project-directory`  | **string** |          The project directory           |            **.**            |
|        `shell`        | **string** |      The shell used to run commands      |          **bash**           |

For details about the default value assigned to the `artifact-descriptor` input, please refer to the related output of [detect-project-tech](../detect-project-tech/README.md).

## Further references

- [detect-project-tech](../detect-project-tech/README.md)

- [detect-branch-version](../detect-branch-version/README.md)

- [aurora-github](../../README.md)
