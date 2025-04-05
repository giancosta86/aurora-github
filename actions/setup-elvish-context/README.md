# setup-elvish-context

Installs an **Elvish** version and optional startup packages, caching everything between multiple jobs of the same workflow execution.

## 🃏Example

```yaml
steps:
  - uses: actions/checkout@v4

  - uses: giancosta86/aurora-github/actions/setup-elvish-context@v10
```

## 💡How it works

1.  - If the requested `Elvish` version was already installed by an execution of this action during the running workflow, use the cached version

    - Otherwise, install the **Elvish** shell, making the `elvish` command available along the system **PATH**

1.  If at least one package was specified in the `packages` input (which **MUST** be either empty or a comma-separated list):

    - If the exact set of packages was already requested by a previous execution of this action during the current workflow, use the cached version

    - Otherwise, install them via `epm:install`, then cache the entire `$epm:managed-dir` directory

**PLEASE, NOTE**: the cache spans over the lifetime of a specific workflow execution - so every new workflow executions will retrieve the latest versions of both Elvish and the startup packages.

## ☑️Requirements

The requested Elvish version **must** include an `epm` module having a `$managed-dir` variable.

Also, if the `packages` input is non-empty, `epm` must provide the following functions:

- `install`

- `installed`

All the above features must follow the protocol described in the documentation for Elvish v0.21.

## 📥Inputs

|        Name        |                    Type                     |                      Description                      | Default value |
| :----------------: | :-----------------------------------------: | :---------------------------------------------------: | :-----------: |
|     `version`      |                 **string**                  |       The Elvish version to download and cache        |  **0.21.0**   |
|     `packages`     | **string** - empty or space/comma-separated |       Packages to install and cache with Elvish       |               |
| `skip-if-existing` |                 **boolean**                 | If the `elvish` command is available, just do nothing |               |

## 🌐Further references

- [Elvish](https://elv.sh/)

- [aurora-github](../../README.md)
