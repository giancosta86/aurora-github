# find-critical-todos

Looks for _critical TODOs_ - that is, instances of the `TODO!` string - in source files.

## Example

```yaml
steps:
  - uses: giancosta86/aurora-github/actions/find-critical-todos@v6
    with:
      source-file-regex: ^\.\/(src|tests)\/.+\.(c|m)?(j|t)sx?$
```

**Please, note:** this action is automatically run by [verify-rust-crate](../verify-rust-crate/README.md), [verify-npm-package](../verify-npm-package/README.md) and [verify-rust-wasm](../verify-rust-wasm/README.md).

## Inputs 📥

|        Name         |    Type     |                            Description                            | Default value |
| :-----------------: | :---------: | :---------------------------------------------------------------: | :-----------: |
| `source-file-regex` | **string**  | The **PCRE** pattern of source file names, for the `find` command |               |
|  `crash-on-found`   | **boolean** |    If **true**, exits with error when critical TODOs are found    |   **true**    |
|   `display-lines`   | **boolean** |               Display the lines with critical TODOs               |   **true**    |
|      `verbose`      | **boolean** |             Show details such as the filterable paths             |   **false**   |
|  `root-directory`   | **string**  |                  The root of the directory tree                   |     **.**     |

**Please, note**: `source-file-regex` should be designed keeping in mind that it will be applied to a path _always_ relative to `root-directory` and _always_ starting with `./`.

## Outputs 📤

|  Name   |    Type     |                                 Description                                  |  Example  |
| :-----: | :---------: | :--------------------------------------------------------------------------: | :-------: |
| `found` | **boolean** | **true** if at least one `TODO!` was found in some file, **false** otherwise | **false** |

## Further references

- [verify-rust-crate](../verify-rust-crate/README.md)

- [verify-npm-package](../verify-npm-package/README.md)

- [verify-rust-wasm](../verify-rust-wasm/README.md)

- [aurora-github](../../README.md)
