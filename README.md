# Boxquell Homebrew tap

[Boxquell](https://github.com/Boxquell/boxquell) for Homebrew, on macOS and Linux.

```sh
brew install boxquell/tap/boxquell
```

or

```sh
brew tap boxquell/tap
brew install boxquell
```

Update with `brew upgrade boxquell`.

Boxquell runs its sandboxes on libkrun. On macOS that comes from another tap:

```sh
brew tap slp/krun && brew install libkrun
```

On Linux install libkrun and libkrunfw from your distribution. Then `boxquell doctor` tells you what is still missing.

The formula installs the released binary; it is rewritten by the release process of the main repository whenever a version is published.
