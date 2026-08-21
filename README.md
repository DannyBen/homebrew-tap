# Homebrew Tap

Personal Homebrew formulae for CLI tools maintained by
[DannyBen](https://github.com/DannyBen).

## Install

Install a formula directly from this tap:

```bash
brew install dannyben/tap/opcode
```

Or tap the repository first:

```bash
brew tap dannyben/tap
brew install opcode
```

## Formulae

| Formula                                          | Description                |
|:-------------------------------------------------|:---------------------------|
| [alf](https://github.com/dannyben/alf)           | Manage Bash aliases        |
| [fuzzycd](https://github.com/dannyben/fuzzycd)   | Fuzzy directory changes    |
| [opcode](https://github.com/dannyben/opcode)     | Local command shortcuts    |
| [rush](https://github.com/dannyben/rush)         | Personal package manager   |
| [shellkin](https://github.com/dannyben/shellkin) | BDD testing for shell CLIs |

## Development

This repository uses [Opcode](https://github.com/DannyBen/opcode) as its command
catalog. Docker is required for the container-based Homebrew commands.

```bash
op check
op check opcode
op outdated
op update opcode 1.4.0
op shell
op pristine
```

`op check` gives each formula its own clean `homebrew/brew:main` container and
runs `brew style`, `brew audit --new --online`, a source install, `brew test`,
and `brew linkage --test`.

`op outdated` checks the tap with Homebrew Livecheck. To update a formula,
provide the reviewed upstream version explicitly:

```bash
op update opcode 1.4.0
op check opcode
```

The update command delegates URL and checksum calculation to
`brew bump-formula-pr --write-only`; it does not create a commit or pull
request.

Ruby gem formulae may be generated with
[Gembrew](https://github.com/DannyBen/gembrew), but this tap's validation
commands are language-neutral and apply to every formula.
