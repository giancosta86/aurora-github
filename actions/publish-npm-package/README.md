# publish-npm-package

Publishes a **NodeJS** package to an [npm](https://www.npmjs.com/) registry.

## Example

The action can be placed right after checking out the source code:

```yaml
steps:
  - uses: actions/checkout@v4

  - uses: giancosta86/aurora-github/actions/publish-npm-package@v6
    with:
      npm-token: ${{ secrets.NPM_TOKEN }}
```

### Remarks

- This action is designed for _publication_ only - not for _verification_: you may want use [verify-npm-package](../verify-npm-package/README.md) for that.

- This action is automatically run by [publish-rust-wasm](../publish-rust-wasm/README.md).

## How it works

1. Invoke [setup-nodejs-context](../setup-nodejs-context/README.md) to set up a NodeJS environment having `pnpm` and dependencies

1. Run `pnpm build` if such script has been declared in **package.json**

1. Run `publish-github-pages` with the `optional` flag enabled

1. Run `pnpm publish`

## Requirements

- The project's package manager must be [pnpm](https://pnpm.io/) - version `9` or later compatible.

- The requirements for [setup-nodejs-context](../setup-nodejs-context/README.md).

- Before the first publication, running with `dry-run` set to **true** is recommended.

## Inputs 📥

|        Name         |    Type     |                   Description                   | Default value |
| :-----------------: | :---------: | :---------------------------------------------: | :-----------: |
|      `dry-run`      | **boolean** |   Run a simulated publication via `--dry-run`   |   **false**   |
|     `npm-token`     | **string**  | The secret token for publishing to the registry |               |
|  `frozen-lockfile`  | **boolean** | Fail if `pnpm-lock.yaml` is missing or outdated |   **true**    |
| `project-directory` | **string**  |     The directory containing `package.json`     |     **.**     |
|       `shell`       | **string**  |         The shell used to run commands          |   **bash**    |

## Further references

- [setup-nodejs-context](../setup-nodejs-context/README.md)

- [verify-npm-package](../verify-npm-package/README.md)

- [publish-rust-wasm](../publish-rust-wasm/README.md)

- [aurora-github](../../README.md)
