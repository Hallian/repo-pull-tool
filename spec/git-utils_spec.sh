Describe "git-utils"
  Include lib/git-utils.sh

  Describe "pullRepo()"
    It "should cd to the dir, change to master and pull"
      git() {
        echo "git $@"
      }
      cd() {
        echo "cd $@"
      }
      When call pullRepo "~/workspace/test-repo"
      The status should be success
      The output should eq "-- Pulling ~/workspace/test-repo
cd ~/workspace/test-repo
git checkout master
git pull"
    End
  End

  Describe "cloneRepo()"
    It "should clone the repo with git"
      git() {
        echo "git $@"
      }
      When call cloneRepo "test-repo" "git@github.com:test-org/test-repo.git" "~/workspace"
      The status should be success
      The output should eq "-- Cloning test-repo
git clone git@github.com:test-org/test-repo.git ~/workspace/test-repo"
    End
  End

  # TODO: test pull clause as well
  Describe "pullOrCloneRepo()"
    It "should either call cloneRepo or pullRepo"
      pullRepo() {
        echo "pullRepo $@"
      }
      cloneRepo() {
        echo "cloneRepo $@"
      }
      When call pullOrCloneRepo "~/workspace" "test-org" "test-repo"
      The status should be success
      The output should eq "cloneRepo test-repo git@github.com:test-org/test-repo.git ~/workspace"
    End

    setup() {
      TMP_DIR=$(mktemp -d)
      mkdir "$TMP_DIR/test-repo"
    }
    teardown() {
      rm -r "$TMP_DIR"
    }
    Before setup
    After teardown
    It "should call pullRepo when target directory exists"
      pullRepo() {
        echo "pullRepo $@"
      }
      cloneRepo() {
        echo "cloneRepo $@"
      }
      When call pullOrCloneRepo "$TMP_DIR" "test-org" "test-repo"
      The status should be success
      The output should eq "pullRepo $TMP_DIR/test-repo"
    End
  End
End
