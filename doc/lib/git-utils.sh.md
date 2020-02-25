`pullRepo()`
------------

Public: Pull git repository

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


