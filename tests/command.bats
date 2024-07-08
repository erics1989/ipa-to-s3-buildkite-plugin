#!/usr/bin/env bats

setup() {
  load "${BATS_PLUGIN_PATH}/load.bash"

  # Uncomment to enable stub debugging
  # export CURL_STUB_DEBUG=/dev/tty

  # you can set variables common to all tests here
  export BUILDKITE_PLUGIN_IPA_TO_S3_TITLE='cool-app'
  export BUILDKITE_PLUGIN_IPA_TO_S3_S3_BUCKET='cool-bucket'
  export BUILDKITE_PLUGIN_IPA_TO_S3_PLIST_PATH='app.plist'
  export BUILDKITE_PLUGIN_IPA_TO_S3_BUNDLE_ID='xyz.ab.cool-app'
  export BUILDKITE_BUILD_NUMBER=420
  export BATS_TEST_OVERRIDE="true"
}

@test "Missing title fails" {
  unset BUILDKITE_PLUGIN_IPA_TO_S3_TITLE

  run "$PWD"/hooks/command

  assert_failure
  assert_output --partial 'No app title provided'
  refute_output --partial 'Running plugin'
}
