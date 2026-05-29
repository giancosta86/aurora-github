# aurora-github

_Elegant CI/CD for GitHub Actions_

![Logo](logo.jpg)

**aurora-github** is a gallery of **GitHub actions** - based on the superlative [Elvish](https://elv.sh/) shell - designed to create _elegant_ and _minimalist_ **workflows** for a variety of technologies, while focusing on best practices such as _default branch protection_, _pull requests_ and _convention-over-configuration_.

For most of the actions, **it is essential to name branches according to semantic versioning** - like `v4.2.7`: this ensures a smooth workflow while remaining largely compatible with other flow architectures - for example, multiple _feature branches_ can stem from a given _version branch_.

The actions can be grouped by technology:

## 🔮 Elvish shell

- [setup-elvish-context](actions/setup-elvish-context/README.md)

- [install-elvish-packages](actions/install-elvish-packages/README.md)

- [verify-elvish-package](actions/verify-elvish-package/README.md)

## 🦀 Rust

- [setup-rust-context](actions/setup-rust-context/README.md)

- [verify-rust-crate](actions/verify-rust-crate/README.md)

- [publish-rust-crate](actions/publish-rust-crate/README.md)

- [extract-rust-snippets](actions/extract-rust-snippets/README.md)

## 📦 NodeJS

- [setup-nodejs-context](actions/setup-nodejs-context/README.md)

- [verify-npm-package](actions/verify-npm-package/README.md)

- [publish-npm-package](actions/publish-npm-package/README.md)

- [inject-subpath-exports](actions/inject-subpath-exports/README.md)

- [check-subpath-exports](actions/check-subpath-exports/README.md)

- [parse-npm-scope](actions/parse-npm-scope/README.md)

## 🦀🌐 Rust wasm-pack

- [verify-rust-wasm](actions/verify-rust-wasm/README.md)

- [publish-rust-wasm](actions/publish-rust-wasm/README.md)

- [install-wasm-pack](actions/install-wasm-pack/README.md)

- [generate-wasm-target](actions/generate-wasm-target/README.md)

## ☕ Java Virtual Machine ecosystem

- [verify-jvm-project](actions/verify-jvm-project/README.md)

- [publish-jvm-project](actions/publish-jvm-project/README.md)

- [install-via-sdkman](actions/install-via-sdkman/README.md)

## 🐍 Python

- [verify-python-package](actions/verify-python-package/README.md)

- [publish-python-package](actions/publish-python-package/README.md)

## 😺 GitHub

- [check-action-references](actions/check-action-references/README.md)

- [publish-github-pages](actions/publish-github-pages/README.md)

- [run-custom-tests](actions/run-custom-tests/README.md)

- [check-project-license](actions/check-project-license/README.md)

- [check-required-jobs](actions/check-required-jobs/README.md)

## 🏷️ Semantic versioning

- [detect-branch-version](actions/detect-branch-version/README.md)

- [enforce-branch-version](actions/enforce-branch-version/README.md)

- [tag-and-release](actions/tag-and-release/README.md)

- [upload-release-assets](actions/upload-release-assets/README.md)

## 🖥 Operating-system utilities

- [run-shell-script](actions/run-shell-script/README.md)

- [find-critical-todos](actions/find-critical-todos/README.md)

- [install-system-packages](actions/install-system-packages/README.md)

## 🌐 Further references

- [GitHub actions](https://docs.github.com/en/actions)

- [Elvish](https://elv.sh/) - Powerful modern shell scripting

- [Google Gemini](https://gemini.google.com) - used to generate the logo

- [GIMP](https://www.gimp.org/) - used to manually retouch the logo
