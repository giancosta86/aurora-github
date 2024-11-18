# enforce-branch-version

Ensures that the version in the artifact descriptor matches the **Git** branch version - by injecting or merely by checking.

## Example

```yaml
steps:
  - uses: giancosta86/aurora-github/actions/enforce-branch-version@v7
    with:
      mode: inject
```

**Please, note**: this action is automatically run by:

- [verify-npm-package](../verify-npm-package/README.md)

- [publish-npm-package](../publish-npm-package/README.md)

- [verify-rust-crate](../verify-rust-crate/README.md)

- [publish-rust-crate](../publish-rust-crate/README.md)

- [publish-github-pages](../publish-github-pages/README.md)

and indirectly by:

- [verify-rust-wasm](../verify-rust-wasm/README.md)

- [publish-rust-wasm](../publish-rust-wasm/README.md)

## How it works

1. If `mode` is **skip**, the action just does nothing

1. The _artifact descriptor_ is computed as follows:

   - If `mode` is **inject**: the `artifact-descriptor` input, if specified, takes precedence over the descriptor detected by [detect-project-tech](../detect-project-tech/README.md)

   - If `mode` is **check**: `artifact-descriptor` is taken into account _only_ if no descriptor is detected by [detect-project-tech](../detect-project-tech/README.md)

1. Evaluate the `mode` input:

   - If the value is **inject**:

     1. _Every_ instance of `0.0.0` in the artifact descriptor will be replaced by the branch version

     1. Display the content of the artifact descriptor

   - If the value is **check**:

     1. Display the content of the artifact descriptor

     1. Perform a _technology-specific_ version check:

        - for **package.json**, check the value in the **version** field

        - for **Cargo.toml**, check the **version** field

        - for any other technology, verify that the branch version exists at least once in the descriptor

## Inputs 📥

|         Name          |          Type           |                        Description                         | Default value |
| :-------------------: | :---------------------: | :--------------------------------------------------------: | :-----------: |
|        `mode`         | `inject`,`check`,`skip` |       Whether and how to enforce the branch version        |               |
| `artifact-descriptor` |       **string**        | Relative path to the artifact descriptor; could be ignored |               |
|  `project-directory`  |       **string**        |            The directory containing the project            |     **.**     |

The `artifact-descriptor` input is ignored in **check** mode if [detect-project-tech](../detect-project-tech/README.md) finds a known descriptor within `project-directory`.

## Further references

- [verify-npm-package](../verify-npm-package/README.md)

- [publish-npm-package](../publish-npm-package/README.md)

- [verify-rust-crate](../verify-rust-crate/README.md)

- [publish-rust-crate](../publish-rust-crate/README.md)

- [publish-github-pages](../publish-github-pages/README.md)

- [verify-rust-wasm](../verify-rust-wasm/README.md)

- [publish-rust-wasm](../publish-rust-wasm/README.md)

- [detect-project-tech](../detect-project-tech/README.md)

- [detect-branch-version](../detect-branch-version/README.md)

- [aurora-github](../../README.md)
