xDescribe "loopReposParallel"
  Include lib/loop-parallel.sh
  It "should call parallel"
    parallel() {
      echo "parallel $@"
    }
    When call loopReposParallel "~/workspace" "test-org" "$(echo -e "test-repo\nanother-repo")"
    The status should be success
    The output should eq "parallel -j 0 pullOrCloneRepo \"$output_dir\" \"$org\" ::: $repos"
  End
  It "should loop"
    pullOrCloneRepo() {
      echo "pullOrCloneRepo $@"
    }
    export -f pullOrCloneRepo
    When call loopReposParallel "~/workspace" "test-org" "$(echo -e "test-repo\nanother-repo")"
    The status should be success
    The output should eq "pullOrCloneRepo ~/workspace test-org test-repo
pullOrCloneRepo ~/workspace test-org another-repo"
  End
End
