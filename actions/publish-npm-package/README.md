# publish-npm-package

Publishes a **NodeJS** package to an [npm](https://www.npmjs.com/) registry.

## Example

```yaml
steps:
  - uses: actions/checkout@v4

  - uses: giancosta86/aurora-github/actions/publish-npm-package@v7
    with:
      npm-token: ${{ secrets.NPM_TOKEN }}
```

### Remarks

- This action is designed for _publication_ only - not for _verification_: you should call [verify-npm-package](../verify-npm-package/README.md) for that instead.

- Before the first publication, running with `dry-run` set to **true** during the _verification_ phase is recommended.

- This action is automatically run by [publish-rust-wasm](../publish-rust-wasm/README.md).

## How it works

1. Run [enforce-branch-version](../enforce-branch-version/README.md), forwarding the `enforce-branch-version` input to its `mode` input.

1. Invoke [setup-nodejs-context](../setup-nodejs-context/README.md) to set up a NodeJS environment having `pnpm` and dependencies.

1. Run `pnpm build` _if_ such script has been declared in **package.json**.

1. Run `publish-github-pages` with the `optional` flag enabled.

1. Run `pnpm publish`

## Requirements

- The requirements for [setup-nodejs-context](../setup-nodejs-context/README.md).

- `npm-token` is _not_ mandatory when `dry-run` is enabled.

- The requirements for [publish-github-pages](../publish-github-pages/README.md) if `website-directory` references an existing directory.

- Before the first publication, running with `dry-run` set to **true** is recommended.

## Inputs 📥

|           Name           |          Type           |                    Description                    | Default value |
| :----------------------: | :---------------------: | :-----------------------------------------------: | :-----------: |
|        `dry-run`         |       **boolean**       |    Run a simulated publication via `--dry-run`    |   **false**   |
|       `npm-token`        |       **string**        |  The secret token for publishing to the registry  |               |
|   `website-directory`    |       **string**        | Relative directory containing the project website |  **website**  |
| `enforce-branch-version` | `inject`,`check`,`skip` |   Whether and how to enforce the branch version   |  **inject**   |
|   `project-directory`    |       **string**        |      The directory containing `package.json`      |     **.**     |

## Further references

- [setup-nodejs-context](../setup-nodejs-context/README.md)

- [enforce-branch-version](../enforce-branch-version/README.md)

- [publish-github-pages](../publish-github-pages/README.md)

- [verify-npm-package](../verify-npm-package/README.md)

- [publish-rust-wasm](../publish-rust-wasm/README.md)

- [aurora-github](../../README.md)
