# find-critical-todos

Looks for _critical TODOs_ - that is, instances of the `TODO!` string - in source files.

## Example

```yaml
steps:
  - uses: giancosta86/aurora-github/actions/find-critical-todos@v4
    with:
      source-file-regex: \.(js|ts)x?$
      crash-on-found: true
```

**Please, note:** this action is automatically run by [verify-rust-crate](../verify-rust-crate/README.md) and [verify-npm-package](../verify-npm-package/README.md).

## Inputs 📥

|        Name         |    Type     |                            Description                            | Default value |
| :-----------------: | :---------: | :---------------------------------------------------------------: | :-----------: |
| `source-file-regex` | **string**  | The **PCRE** pattern of source file names, for the `find` command |               |
|  `crash-on-found`   | **boolean** |    If **true**, exits with error when critical TODOs are found    |               |
|   `display-lines`   | **boolean** |               Display the lines with critical TODOs               |   **true**    |
|  `root-directory`   | **string**  |                  The root of the directory tree                   |     **.**     |
|       `shell`       | **string**  |                  The shell used to run commands                   |   **bash**    |

## Outputs 📤

|  Name   |    Type     |                                 Description                                  |  Example  |
| :-----: | :---------: | :--------------------------------------------------------------------------: | :-------: |
| `found` | **boolean** | **true** if at least one `TODO!` was found in some file, **false** otherwise | **false** |

## Further references

- [verify-rust-crate](../verify-rust-crate/README.md)

- [verify-npm-package](../verify-npm-package/README.md)

- [aurora-github](../../README.md)
