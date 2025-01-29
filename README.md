# aurora-github

_Elegant workflows for GitHub Actions_

![Schema](docs/schema.png)

**aurora-github** is a gallery of GitHub actions designed to create elegant and minimalist _pipelines_ for a variety of technologies - focusing on best practices such as _default branch protection_, _pull requests_ and _convention-over-configuration_.

In particular, for most actions **it is essential to name branches according to semantic versioning** - like `v4.2.7`: this ensures a smooth workflow while remaning largely compatible with other flows - for example, multiple _feature branches_ can stem from a given _version branch_.

The actions can be grouped by technology:

## 🦀Rust

- [verify-rust-crate](actions/verify-rust-crate/README.md)

- [publish-rust-crate](actions/publish-rust-crate/README.md)

- [check-rust-versions](actions/check-rust-versions/README.md)

- [extract-rust-snippets](actions/extract-rust-snippets/README.md)

## 📦NodeJS package

- [verify-npm-package](actions/verify-npm-package/README.md)

- [publish-npm-package](actions/publish-npm-package/README.md)

- [inject-subpath-exports](actions/inject-subpath-exports/README.md)

- [check-subpath-exports](actions/check-subpath-exports/README.md)

- [setup-nodejs-context](actions/setup-nodejs-context/README.md)

- [parse-npm-scope](actions/parse-npm-scope/README.md)

## 🦀Rust 🌐WebAssembly

- [verify-rust-wasm](actions/verify-rust-wasm/README.md)

- [publish-rust-wasm](actions/publish-rust-wasm/README.md)

- [install-wasm-pack](actions/install-wasm-pack/README.md)

- [generate-wasm-target](actions/generate-wasm-target/README.md)

## ☕Java ecosystem

- [verify-jvm-project](actions/verify-jvm-project/README.md)

- [publish-jvm-project](actions/publish-jvm-project/README.md)

- [install-via-sdkman](actions/install-via-sdkman/README.md)

## 🐍Python

- [verify-python-package](actions/verify-python-package/README.md)

- [publish-python-package](actions/publish-python-package/README.md)

## 😺GitHub

- [check-action-references](actions/check-action-references/README.md)

- [publish-github-pages](actions/publish-github-pages/README.md)

- [run-custom-tests](actions/run-custom-tests/README.md)

- [check-project-license](actions/check-project-license/README.md)

## 🏷️Semantic versioning

- [detect-branch-version](actions/detect-branch-version/README.md)

- [enforce-branch-version](actions/enforce-branch-version/README.md)

- [tag-and-release](actions/tag-and-release/README.md)

- [upload-release-assets](actions/upload-release-assets/README.md)

## 🧰General-purpose utilities

- [find-critical-todos](actions/find-critical-todos/README.md)

- [install-system-packages](actions/install-system-packages/README.md)

## 🌐Further references

- [GitHub actions](https://docs.github.com/en/actions)
