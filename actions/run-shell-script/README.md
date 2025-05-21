# run-shell-script

Runs a shell script, supporting different shells.

## 🃏 Example

```yaml
steps:
  - uses: giancosta86/aurora-github/actions/run-shell-script@v11
    with:
      script-file: process-data #Can detect both the extension and the shell automatically
      working-directory: src
```

## 💡 How it works

1. Look for the given `script-file` within `working-directory`; if it does not exist, try adding the following extensions, in this order:

   1. **.elv**

   1. **.sh**

   If no script file can still be found, exit the process - with an error, unless `optional` is set to **true**.

1. If `shell` is specified, it will be invoked to run the script; otherwise, detect it from the extension of the actual script file:

   | Extension | Default shell |
   | :-------: | :-----------: |
   | **.elv**  |   `elvish`    |
   |  **.sh**  |    `bash`     |

   If no shell can still be detected, exit the process - with an error, unless `optional` is set to **true**.

1. Within `working-directory`, run:

   ```
   <actual shell> <actual script file> <args>
   ```

## 📥 Inputs

|        Name         |           Type           |                         Description                         | Default value |
| :-----------------: | :----------------------: | :---------------------------------------------------------: | :-----------: |
|     `optional`      |       **boolean**        |          Exit successfully if no script can be run          |   **false**   |
|    `script-file`    |        **string**        | Relative path - in `working-directory` - to the script file |               |
|       `shell`       |        **string**        |              The shell used to run the script               |               |
|       `args`        | **comma-separated list** |            Arguments to be passed to the script             |               |
| `working-directory` |        **string**        |                    The working directory                    |     **.**     |

## 🌐 Further references

- [aurora-github](../../README.md)
