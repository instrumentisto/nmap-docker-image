#!/usr/bin/env bats


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
