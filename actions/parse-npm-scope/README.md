# parse-npm-scope

Parses a mandatory [npm scope](https://docs.npmjs.com/cli/v10/using-npm/scope) declaration.

## Example

```yaml
steps:
  - id: scope-parser
    uses: giancosta86/aurora-github/actions/parse-npm-scope@v3
    with:
      scope: giancosta86
```

## Requirements

- The `scope` input _must_ be declared. It can be:

  - `<ROOT>`, for a scope-less package in the root of the npm registry

  - the _package scope_ as a string, with an optional leading `@`

## Inputs

|  Name   |    Type    |          Description           | Default value |
| :-----: | :--------: | :----------------------------: | :-----------: |
| `scope` | **string** |     The npm scope to parse     |               |
| `shell` | **string** | The shell used to run commands |   **bash**    |

## Outputs

|      Name      |    Type    |                        Description                        |     Example     |
| :------------: | :--------: | :-------------------------------------------------------: | :-------------: |
| `actual-scope` | **string** | The scope without '@', or the empty string for root scope | **giancosta86** |

## Further references

- [npm scope](https://docs.npmjs.com/cli/v10/using-npm/scope)

- [aurora-github](../../README.md)
