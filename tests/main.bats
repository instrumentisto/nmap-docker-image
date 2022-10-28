#!/usr/bin/env bats


@test "Built on correct arch" {
  run docker run --rm --pull never --platform $PLATFORM \
                 --entrypoint sh $IMAGE -c \
    'uname -m'
  [ "$status" -eq 0 ]
  if [ "$PLATFORM" = "linux/amd64" ]; then
    [ "$output" = "x86_64" ]
  elif [ "$PLATFORM" = "linux/arm/v6" ]; then
    [ "$output" = "armv7l" ]
  elif [ "$PLATFORM" = "linux/arm/v7" ]; then
    [ "$output" = "armv7l" ]
  elif [ "$PLATFORM" = "linux/arm64/v8" ]; then
    [ "$output" = "aarch64" ]
  else
    [ "$output" = "$(echo $PLATFORM | cut -d '/' -f2-)" ]
  fi
}


@test "nmap is installed" {
  run docker run --rm --pull never --platform $PLATFORM \
                 --entrypoint sh $IMAGE -c \
    'which nmap'
  [ "$status" -eq 0 ]
}

@test "nmap runs ok" {
  run docker run --rm --pull never --platform $PLATFORM \
                 --entrypoint sh $IMAGE -c \
    'nmap --help'
  [ "$status" -eq 0 ]
}


@test "nping is installed" {
  run docker run --rm --pull never --platform $PLATFORM \
                 --entrypoint sh $IMAGE -c \
    'which nping'
  [ "$status" -eq 0 ]
}

@test "nping runs ok" {
  run docker run --rm --pull never --platform $PLATFORM \
                 --entrypoint sh $IMAGE -c \
    'nping --help'
  [ "$status" -eq 0 ]
}


@test "ncat is installed" {
  run docker run --rm --pull never --platform $PLATFORM \
                 --entrypoint sh $IMAGE -c \
    'which ncat'
  [ "$status" -eq 0 ]
}

@test "ncat runs ok" {
  run docker run --rm --pull never --platform $PLATFORM \
                 --entrypoint sh $IMAGE -c \
    'ncat --help'
  [ "$status" -eq 0 ]
}
