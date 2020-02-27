# repo-pull-tool documentation

## Docs by file

* [lib/argbash.sh](lib/argbash.sh.md)
* [lib/curl-utils.sh](lib/curl-utils.sh.md)
* [lib/git-utils.sh](lib/git-utils.sh.md)
* [lib/github.sh](lib/github.sh.md)
* [lib/loop-parallel.sh](lib/loop-parallel.sh.md)
* [lib/loop-xargs.sh](lib/loop-xargs.sh.md)
* [repo-pull-tool.sh](repo-pull-tool.sh.md)

## Single page docs

`_positionals`
--------------

THE DEFAULTS INITIALIZATION - POSITIONALS


`_arg_filter`
-------------

THE DEFAULTS INITIALIZATION - OPTIONALS


`getBody()`
-----------

Public: Get body from curl -i output

Removes carriage returns with sed due to curl sometimes returning those Removes everthing before the first empty line with sed.

* $1 - curl -i output

Outputs curl response body


`getHeaders()`
--------------

Public: Get headers from curl -i output

Removes carriage returns with sed due to curl sometimes returning those Removes everthing after the first empty line with sed.

* $1 - curl -i output

Outputs curl response headers


`getNextPageLink()`
-------------------

Public: Get next page link from curl headers.

Parses the "next" page link from Link header.

* $1 - curl -i header output from getHeaders

Outputs the parsed "next" http link


`pullRepo()`
------------

Public: Pull git repository.

Changes to the supplied git directory, checks out the master branch and pulls the repository.

* $1 - path to repository

Outputs git pull output


`cloneRepo()`
-------------

Public: Clones a git repository

Clone a git repository to a containing directory.

* $1 - repository name
* $2 - repository ssh_url
* $3 - target containing directory path

Outputs git clone output


`pullOrCloneRepo()`
-------------------

Public: Pulls or clones a git repository

* $1 - containing output directory, e.g. `~/workspace`
* $2 - github organization
* $3 - repository name

Outputs pullRepo or cloneRepo output


`filterRepos()`
---------------

Public: Filters repositories (or input lines rather) with regex

Takes a list of filters and list of repositories. Filters are added to a grep command as multiple -e regex options.

* $1 - list of filters in grep regex, e.g. "^project1- ^project7-"
* $2 - list of repos

Outputs list of repos filtered with grep


`getReposGithubOrg()`
---------------------

Public: Fetch a list of repositories for an organization from GitHub API

Calls GitHub api with curl and parses the name field from the response. It will then parse the "next" link from the Link header and if present will increment the page number and go to the next page. TODO: IMPROVEMENT: Actually use the next link value instead of just incrementing the previous page number.

* $1 - github token
* $2 - github organization name
* $3 - request page
* $4 - return repository name only, true/false
* $5 - number of repos per request page

Outputs list of organization repositories


`checkGithubToken()`
--------------------

Public: Check the existence of $GITHUB_TOKEN

Side effects: Value of $GITHUB_TOKEN comes from outside of function scope


`loopReposParallel()`
---------------------

Public: Run pullOrCloneRepo for a list of repos using parallel

* $1 - containing output directory
* $2 - github organization
* $3 - list of repos

Outputs pullOrCloneRepo output


`loopReposXargs()`
------------------

Public: Run pullOrCloneRepo for a list of repos using xargs

* $1 - containing output directory
* $2 - github organization
* $3 - list of repos

Outputs pullOrCloneRepo output all jumbled up since xargs doesn't keep track of it


`main()`
--------

Internal: main function

Calls GitHub and pulls repos.


