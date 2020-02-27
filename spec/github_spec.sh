Describe "GitHub"
  Include lib/curl-utils.sh
  Include lib/github.sh

  Describe "getReposGithubOrg()"
    It "should return a list of repo names when github api call succeeds"
      curl() {
        cat spec/fixtures/github-org-curl-response.txt
      }
      When call getReposGithubOrg "fake-org" "fake-github-token" 1
      The output should eq "test-repo	ssh-url-test-repo
another-repo	another-repo"
    End

    Describe "should not fail when"
      It "curl returns an invalid response"
        curl() {
          echo "Headers\n\n{\"message\":\"this is not the page you were looking for\"}"
        }
        When call getReposGithubOrg "fake-org" "fake-github-token"
        The status should be success
        The output should eq ""
      End

      It "curl isn't installed"
        curl() {
          not-installed
        }
        When call getReposGithubOrg "fake-org" "fake-github-token"
        The status should be success
        The output should eq ""
        The stderr should not eq ""
        # The stderr should eq "/usr/bin/bash: line 85: not-installed: command not found"
      End
    End

    It "calls github api with curl and proper parameters"
      curl() {
        echo -e "Headers\n\n[{\"name\":\"$*\"}]"
      }
      When call getReposGithubOrg "fake-org" "fake-github-token" 1 25 true
      The output should eq "-i -u :fake-org -s https://api.github.com/orgs/fake-github-token/repos?per_page=25&page=1"
    End
  End

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
End
