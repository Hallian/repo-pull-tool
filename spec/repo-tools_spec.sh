Describe "repo-pull-tool"
  Include repo-pull-tool.sh
  Describe "checkGithubToken()"
    Describe "check for existence of GITHUB_TOKEN in environment"
      clearGithubToken() {
        unset GITHUB_TOKEN
      }

      setGithubToken() {
        export GITHUB_TOKEN=fake-github-token
      }

      It "and fail if it's not set"
        BeforeRun "clearGithubToken"
        When run checkGithubToken
        The status should be failure
        The output should eq "No GITHUB_TOKEN found! Specify one in ~/.bashrc for example."
      End

      It "and not fail if it's set"
        BeforeRun "setGithubToken"
        When run checkGithubToken
        The status should be success
      End
    End
  End

  Describe "filterRepos()"
    It "should filter repos"
      When call filterRepos "^prefix-" "prefix-repo-1
prefix-repo-2
not-one-of-them
prefix-repo-3"
      The status should be success
      The output should eq "prefix-repo-1
prefix-repo-2
prefix-repo-3"
    End
  End
End
