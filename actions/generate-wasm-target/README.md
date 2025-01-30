# generate-wasm-target

Generates the source files for a **WebAssembly** target from a **Rust** project.

## 🃏Example

```yaml
steps:
  - uses: giancosta86/aurora-github/actions/generate-wasm-target@v10
    with:
      target: web
      npm-scope: npmuser
      development: true
      target-directory: pkg
      project-directory: .
```

## 💡How it works

1. Invoke [wasm-pack](https://rustwasm.github.io/wasm-pack/) - with arguments depending on the inputs - to generate a WebAssembly project from the given Rust sources.

1. If `nodejs-version` is passed, inject it into the `engines / node` field of **package.json**

1. If `pnpm-version` is passed, inject it into the `packageManager` field of **package.json**, with value preceded by `pnpm@`

1. If **package.json** was actually generated, display it

## ☑️Requirements

- The `wasm-pack` command must be available in the system - for example, via [install-wasm-pack](../install-wasm-pack/README.md).

## 📥Inputs

|        Name         |    Type     |                             Description                              | Default value |
| :-----------------: | :---------: | :------------------------------------------------------------------: | :-----------: |
|      `target`       | **string**  |             The target of the `wasm-pack build` command              |               |
|     `npm-scope`     | **string**  |            The package scope or `<ROOT>`, for npm targets            |               |
|  `nodejs-version`   | **string**  |           The `engines / node` version within package.json           |               |
|   `pnpm-version`    | **string**  |      The `packageManager` reference to pnpm within package.json      |               |
|    `development`    | **boolean** |                        Enable debugging info                         |               |
| `target-directory`  | **string**  | Directory (relative to `project-directory`) for the generated target |               |
| `project-directory` | **string**  |                The directory containing `Cargo.toml`                 |     **.**     |

## 🌐Further references

- [wasm-pack](https://rustwasm.github.io/wasm-pack/)

- [install-wasm-pack](../install-wasm-pack/README.md)

- [parse-npm-scope](../parse-npm-scope/README.md)

- [aurora-github](../../README.md)
