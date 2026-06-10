# find-regex-pattern

Finds and displays matches of the given regex in all the requested file patterns, optionally crashing.

## 🃏 Example

```yaml
steps:
  - uses: giancosta86/aurora-github/actions/find-regex-pattern@v11
    with:
      working-directory: tests/some-dir/src
      files: *.txt
      regex: TODO!
```

## 📥 Inputs

|        Name         |             Type              |                        Description                         | Default value |
| :-----------------: | :---------------------------: | :--------------------------------------------------------: | :-----------: |
|       `files`       |          **string**           |              _Comma-separated_ file patterns               |     `**`      |
|       `regex`       |          **string**           |          The **Perl** regular expression pattern           |               |
|    `crash-when`     | **found\|not-found\|(empty)** |                When the action should crash                |               |
|   `crash-message`   |          **string**           | The message to show upon crash in lieu of the default ones |               |
|       `quiet`       |          **boolean**          |                  Do not show the matches                   |    `false`    |
| `working-directory` |          **string**           |         The directory where the action should run          |      `.`      |

## 📤 Outputs

|  Name   |    Type     |                                Description                                 |  Example  |
| :-----: | :---------: | :------------------------------------------------------------------------: | :-------: |
| `found` | **boolean** | **true** if at least one match was found in some file, **false** otherwise | **false** |

## 🌐 Further references

- [aurora-github](../../README.md)
