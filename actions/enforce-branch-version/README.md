# enforce-branch-version

Ensures that the version in the artifact descriptor matches the **Git** branch version - by injecting or merely by checking.

## 🃏Example

```yaml
steps:
  - uses: giancosta86/aurora-github/actions/enforce-branch-version@v9
    with:
      mode: inject
```

**Please, note**: this action is automatically run by:

- [verify-npm-package](../verify-npm-package/README.md)

- [publish-npm-package](../publish-npm-package/README.md)

- [verify-rust-crate](../verify-rust-crate/README.md)

- [publish-rust-crate](../publish-rust-crate/README.md)

- [verify-jvm-project](../verify-jvm-project/README.md)

- [publish-jvm-project](../publish-jvm-project/README.md)

- [verify-python-package](../verify-python-package/README.md)

- [publish-python-package](../publish-python-package/README.md)

- [publish-github-pages](../publish-github-pages/README.md)

and indirectly by:

- [verify-rust-wasm](../verify-rust-wasm/README.md)

- [publish-rust-wasm](../publish-rust-wasm/README.md)

## 💡How it works

1. If `mode` is **skip**, just exit the action flow.

1. If `artifact-descriptor` is not specified, try to detect it from a list of supported ones - currently:

   - **package.json** - for 📦**NodeJS**

   - **Cargo.toml** - for 🦀**Rust**

   - **pom.xml** - for 🪶**Maven**

   - **build.gradle** or **build.gradle.kts** - for 🐘**Gradle**

   - **pyproject.toml** - for 🐍**Python**

1. Evaluate the `mode` input:

   - If the value is **inject**:

     1. _Every_ instance of `0.0.0` in the artifact descriptor will be replaced by the branch version

     1. Display the content of the artifact descriptor

   - If the value is **check**:

     1. Display the content of the artifact descriptor

     1. Perform a _technology-specific_ version check:

        - for 📦**NodeJS**, check the **version** field in **package.json**

        - for 🦀**Rust**, check the **version** field in **Cargo.toml**

        - for 🪶**Maven**, check the `<version>` field in **pom.xml**

        - for 🐘**Gradle**, check the `version` field in **build.gradle** or **build.gradle.kts**

        - for 🐍**Python**, check the `version` field in **pyproject.toml**

        - for any other technology, verify that the branch version exists at least once in the descriptor

## ☑️Requirements

- The `artifact-descriptor` - no matter whether declared or detected - must exist in the file system.

## 📥Inputs

|         Name          |          Type           |                Description                | Default value |
| :-------------------: | :---------------------: | :---------------------------------------: | :-----------: |
|        `mode`         | `inject`,`check`,`skip` | How the branch version should be enforced |               |
| `artifact-descriptor` |       **string**        | Relative path to the artifact descriptor  |               |
|  `project-directory`  |       **string**        |   The directory containing the project    |     **.**     |

## 🌐Further references

- [verify-npm-package](../verify-npm-package/README.md)

- [publish-npm-package](../publish-npm-package/README.md)

- [verify-rust-crate](../verify-rust-crate/README.md)

- [publish-rust-crate](../publish-rust-crate/README.md)

- [verify-jvm-project](../verify-jvm-project/README.md)

- [publish-jvm-project](../publish-jvm-project/README.md)

- [verify-python-package](../verify-python-package/README.md)

- [publish-python-package](../publish-python-package/README.md)

- [publish-github-pages](../publish-github-pages/README.md)

- [verify-rust-wasm](../verify-rust-wasm/README.md)

- [publish-rust-wasm](../publish-rust-wasm/README.md)

- [detect-branch-version](../detect-branch-version/README.md)

- [aurora-github](../../README.md)
