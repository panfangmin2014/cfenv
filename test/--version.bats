#!/usr/bin/env bats

load test_helper

setup() {
  mkdir -p "$HOME"
  git config --global user.name  "Tester"
  git config --global user.email "tester@test.local"
}

git_commit() {
  git commit --quiet --allow-empty -m "empty"
}

@test "default version" {
  assert [ ! -e "$CFENV_ROOT" ]
  run cfenv---version
  assert_success
  [[ $output == "cfenv 1."* ]]
}

@test "reads version from git repo" {
  mkdir -p "$CFENV_ROOT"
  cd "$CFENV_ROOT"
  git init
  git_commit
  git tag v0.4.1
  git_commit
  git_commit

  cd "$CFENV_TEST_DIR"
  run cfenv---version
  assert_success
  [[ $output == "cfenv 0.4.1-2-g"* ]]
}

@test "prints default version if no tags in git repo" {
  mkdir -p "$CFENV_ROOT"
  cd "$CFENV_ROOT"
  git init
  git_commit

  cd "$CFENV_TEST_DIR"
  run cfenv---version
  [[ $output == "cfenv 1."* ]]
}
