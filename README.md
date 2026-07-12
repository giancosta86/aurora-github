# aurora-github

_Elegant CI/CD for GitHub Actions_

![Logo](logo.jpg)

**aurora-github** is a gallery of _Linux-based_ **GitHub actions** - relying on the superlative [Elvish](https://elv.sh/) shell - designed to create _elegant_ and _minimalist_ **workflows** for a variety of technologies, while focusing on best practices such as _default branch protection_, _pull requests_ and _convention-over-configuration_.

For most of the actions, **it is essential to name branches according to semantic versioning** - like `v4.2.7`: this ensures a smooth workflow while remaining largely compatible with other flow architectures - for example, multiple _feature branches_ can stem from a given _version branch_.

The actions can be grouped by technology:

## 🔮 Elvish shell

- [run-elvish-tests](actions/run-elvish-tests/README.md)

- [run-velvet-code](actions/run-velvet-code/README.md)

- [verify-elvish-package](actions/verify-elvish-package/README.md)

## 🦀 Rust

- [setup-rust-context](actions/setup-rust-context/README.md)

- [verify-rust-crate](actions/verify-rust-crate/README.md)

- [publish-rust-crate](actions/publish-rust-crate/README.md)

## 📦 NodeJS

- [setup-nodejs-context](actions/setup-nodejs-context/README.md)

- [verify-npm-package](actions/verify-npm-package/README.md)

- [publish-npm-package](actions/publish-npm-package/README.md)

- [check-subpath-exports](actions/check-subpath-exports/README.md)

## 🦀🌐 Rust wasm-pack

- [verify-rust-wasm](actions/verify-rust-wasm/README.md)

- [publish-rust-wasm](actions/publish-rust-wasm/README.md)

## ☕ Java Virtual Machine ecosystem

- [verify-jvm-project](actions/verify-jvm-project/README.md)

- [publish-jvm-project](actions/publish-jvm-project/README.md)

- [install-via-sdkman](actions/install-via-sdkman/README.md)

## 🐍 Python

- [verify-python-package](actions/verify-python-package/README.md)

- [publish-python-package](actions/publish-python-package/README.md)

## 🔎 Regular expressions

- [find-regex-pattern](actions/find-regex-pattern/README.md)

- [find-critical-todos](actions/find-critical-todos/README.md)

- [replace-regex-pattern](actions/replace-regex-pattern/README.md)

## 😺 GitHub

- [check-action-references](actions/check-action-references/README.md)

- [publish-github-pages](actions/publish-github-pages/README.md)

- [check-project-license](actions/check-project-license/README.md)

- [check-required-jobs](actions/check-required-jobs/README.md)

## 🏷️ Semantic versioning

- [detect-branch-version](actions/detect-branch-version/README.md)

- [inject-branch-version](actions/inject-branch-version/README.md)

- [tag-and-release](actions/tag-and-release/README.md)

- [upload-release-assets](actions/upload-release-assets/README.md)

## 🖥 Operating-system utilities

- [install-system-packages](actions/install-system-packages/README.md)

## 🌐 Further references

- [GitHub actions](https://docs.github.com/en/actions)

- [Ethereal](https://github.com/giancosta86/ethereal) - _Elegant utilities for the Elvish shell_

- [Velvet](https://github.com/giancosta86/velvet) - _Smooth, functional testing in the Elvish shell_

- [astral-bridge](https://github.com/giancosta86/astral-bridge) - _Bridge between the Elvish shell and NodeJS_

- [primrose](https://github.com/giancosta86/primrose) - _Elegant file analysis in Elvish_

- [Elvish](https://elv.sh/) - Powerful modern shell scripting

- [Google Gemini](https://gemini.google.com) - used to generate the logo

- [GIMP](https://www.gimp.org/) - used to manually retouch the logo
