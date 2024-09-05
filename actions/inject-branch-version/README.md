# inject-branch-version

Injects into a descriptor the version detected from the current Git branch.

## Example

```yaml
steps:
  - uses: giancosta86/aurora-github/actions/inject-branch-version@v2
    with:
      artifact-file: ./package.json
```

## Requirements

- The artifact file should contain at least one occurrence of `0.0.0`: they will all be replaced by the version detected from the current Git branch.

- The ones described for [detect-branch-version](../detect-branch-version/README.md)

## Inputs

|      Name       |    Type    |                         Description                          | Default value |
| :-------------: | :--------: | :----------------------------------------------------------: | :-----------: |
| `artifact-file` | **string** | The artifact descriptor - such as Cargo.toml or package.json |               |
|     `shell`     | **string** |                The shell used to run commands                |   **bash**    |

## Further references

- [detect-branch-version](../detect-branch-version/README.md)

- [aurora-github](../../README.md)
