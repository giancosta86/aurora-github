# install-system-packages

Installs software using the platform's package manager.

## Example

```yaml
steps:
  - uses: giancosta86/aurora-github/actions/install-system-packages@v6
    with:
      packages: moreutils
```

## Requirements

This action currently requires an operating system with the `apt-get` package manager.

## How it works

This action installs the requested packages as **root**, without asking for confirmation.

## Inputs 📥

|    Name    |    Type    |                        Description                         | Default value |
| :--------: | :--------: | :--------------------------------------------------------: | :-----------: |
| `packages` | **string** | The packages to install, separated by any spaces or commas |               |

## Further references

- [aurora-github](../../README.md)
