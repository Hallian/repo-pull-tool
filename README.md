# rpt - repo-pull-tool.sh

[![Windows](https://github.com/Hallian/repo-pull-tool/workflows/Windows/badge.svg)](https://github.com/Hallian/repo-pull-tool/actions?query=workflow%3AWindows)
[![Ubuntu](https://github.com/Hallian/repo-pull-tool/workflows/Ubuntu/badge.svg)](https://github.com/Hallian/repo-pull-tool/actions?query=workflow%3AUbuntu)
[![MacOS](https://github.com/Hallian/repo-pull-tool/workflows/MacOS/badge.svg)](https://github.com/Hallian/repo-pull-tool/actions?query=workflow%3AMacOS)
[![shellcheck](https://github.com/Hallian/repo-pull-tool/workflows/shellcheck/badge.svg)](https://github.com/Hallian/repo-pull-tool/actions?query=workflow%3Ashellcheck)

```
$ rpt -h
Clone or pull multiple GitHub organization repositories.
Usage: rpt [-f|--filter <arg>] [-g|--github-org <arg>] [-h|--help] <workspace>
        <workspace>: directory where git repositories are located
        -f, --filter: regex filters, space separated list (no default)
        -g, --github-org: GitHub Organisation name (no default)
        -h, --help: Prints help
```

This tool is designed to automate the task of pulling multiple git repositories. It will
scan your GitHub organization's repos based on a filter and clone or pull them.

## Install rpt

### Depedencies

This script requires:
* [jq](https://stedolan.github.io/jq/)
* git
* gnu parallel or xargs
* curl, sed, grep, etc. 

### Install from source

Installing is just cloning the repository. 

```
git clone git@github.com:Hallian/repo-pull-tool.git ~/.rpt
```

#### Create alias

You can either just run the script directly with `~/.rpt/repo-pull-tool.sh` or you can make an alias, e.g. `rpt`:

```
echo 'alias rpt="~/.rpt/repo-pull-tool.sh"' >> ~/.bashrc
# OR:
echo 'alias rpt="~/.rpt/repo-pull-tool.sh"' >> ~/.bash_profile
```

## Usage

### Prerequisites

#### GitHub personal access token

This script needs a [GitHub personal access token token](https://help.github.com/en/github/authenticating-to-github/creating-a-personal-access-token-for-the-command-line) to query the GitHub API for your organization's repositories.
You can either supply this each time your run the script or put it in some place convenient, e.g. `~/.bashrc`, `~/.bash_profile`, ...
```
export GITHUB_TOKEN="github-token-with-repo-access"
```

### Run `repo-pull-tool.sh`

The script takes GitHub organization name as the first parameter, a workspace directory i.e. where the repositories
are/will be cloned to and finally a list of regex filters.

```
rpt ~/workspace -g GitHubOrgName -f "^awesome-project- ^boring-project"
```

The above pull all repositories starting with `awesome-project-` and `boring-project` into `~/workspace`.

### Make an alias

To make things easy and quick, make aliases to your `~/.bashrc`:

```
alias awesome-pull='rpt GitHubOrgName ~/workspace "^awesome-project-"'
alias boring-pull='rpt GitHubOrgName ~/workspace "^boring-project-"'
```


### Help

To get details on the various parameters you can obtain help with the `-h` flag.

```
rpt -h
```

## Testing

This project endevours to provide extensive [shellspec](https://shellspec.info/)
tests to ensure functionality of the script on all OSes. The aim of this tool is
to be 100% covered with tests and work on all major operating systems. 

### Running tests

```
shellspec
```

## Motivation

Why write this script? Partly because I got tired of writing the same repo pull script
every time I switched consulting gigs to a new client and partly due to a desire to see
if one could in fact write maintainable bash scripts that could be expected to run on
all operating systems and not break at the drop of a hat. Extensive automated testing
seems like the only feasible way to approach the matter.
