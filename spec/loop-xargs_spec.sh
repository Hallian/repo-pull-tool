Describe "loopReposXargs"
  Include lib/loop-xargs.sh
  It "should call xargs"
    xargs() {
      echo "xargs $@"
    }
    When call loopReposXargs "~/workspace" "test-org" "$(echo -e "test-repo\nanother-repo")"
    The status should be success
    The output should eq "xargs -I {} -n 1 -P 0 bash -c pullOrCloneRepo \"\$output_dir\" \"\$org\" \"\$@\" _ {}"
  End
  It "should loop"
    pullOrCloneRepo() {
      echo "pullOrCloneRepo $@"
    }
    export -f pullOrCloneRepo
    When call loopReposXargs "~/workspace" "test-org" "$(echo -e "test-repo\nanother-repo")"
    The status should be success
    The output should eq "pullOrCloneRepo ~/workspace test-org test-repo
pullOrCloneRepo ~/workspace test-org another-repo"
  End
End
