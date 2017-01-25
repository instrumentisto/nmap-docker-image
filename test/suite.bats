#!/usr/bin/env bats


@test "post_push hook is up-to-date" {
  run sh -c "cat Makefile | grep 'TAGS ?= ' | cut -d ' ' -f 3"
  [ "$status" -eq 0 ]
  [ ! "$output" = '' ]
  expected="$output"

  run sh -c "cat hooks/post_push | grep 'for tag in' \
                                 | cut -d '{' -f 2 \
                                 | cut -d '}' -f 1"
  [ "$status" -eq 0 ]
  [ ! "$output" = '' ]
  actual="$output"

  [ "$actual" = "$expected" ]
}


@test "nmap is installed" {
  run docker run --rm --entrypoint sh $IMAGE -c 'which nmap'
  [ "$status" -eq 0 ]
}

@test "nmap runs ok" {
  run docker run --rm --entrypoint sh $IMAGE -c 'nmap --help'
  [ "$status" -eq 0 ]
}


@test "nping is installed" {
  run docker run --rm --entrypoint sh $IMAGE -c 'which nping'
  [ "$status" -eq 0 ]
}

@test "nping runs ok" {
  run docker run --rm --entrypoint sh $IMAGE -c 'nping --help'
  [ "$status" -eq 0 ]
}


@test "ncat is installed" {
  run docker run --rm --entrypoint sh $IMAGE -c 'which ncat'
  [ "$status" -eq 0 ]
}

@test "ncat runs ok" {
  run docker run --rm --entrypoint sh $IMAGE -c 'ncat --help'
  [ "$status" -eq 0 ]
}
