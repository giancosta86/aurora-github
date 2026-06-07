# run-velvet-code

Runs inline tests in the **Elvish** shell with [Velvet](https://github.com/giancosta86/velvet).

## 🃏 Example

```yaml
steps:
  - uses: giancosta86/aurora-github/actions/run-velvet-code@v11
    with:
      code: |
        >> 'The build script' {
          >> 'should create the expected output' {
            put dist |
              should-be-dir

            path:join dist my-app.jar |
              should-be-regular
          }
        }
```

## 💡 How it works

1. Ensures the **Elvish** shell is installed.

1. Installs the requested **Velvet** version.

1. Creates a _temporary test script_ containing the test code passed via the `code` input.

1. Runs `velvet &flawless` on the temporary script.

1. Deletes the temporary script.

## 💬 Remarks

This action is especially useful to perform tests _on the fly_ within the CI/CD pipeline - for example, when _testing custom GitHub Actions_.

## ☑️ Requirements

The Velvet version must be at least **v4**.

## 📥 Inputs

|        Name         |     Type      |                      Description                      | Default value |
| :-----------------: | :-----------: | :---------------------------------------------------: | :-----------: |
|       `code`        |  **string**   | The test code - the content of a **.test.elv** script |               |
|  `velvet-version`   |  **string**   |               The Velvet version to use               |    **v4**     |
| `working-directory` | **directory** |             The `$pwd` for the test code              |     **.**     |

## 🌐 Further references

- [Velvet](https://github.com/giancosta86/velvet) - _Smooth, functional testing in the Elvish shell_

- [Elvish](https://elv.sh/)

- [aurora-github](../../README.md)
