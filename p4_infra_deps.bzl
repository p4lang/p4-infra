"""Third party dependencies.

Please read carefully before adding new dependencies:
- Any dependency can break all of P4 Infra. Please be mindful of that before
  adding new dependencies. Try to stick to stable versions of widely used libraries.
  Do not depend on private repositories and forks.
- Fix dependencies to a specific version or commit, so upstream changes cannot break
  p4-infra. Prefer releases over arbitrary commits when both are available.
"""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

def p4_infra_deps():
    """Sets up 3rd party workspaces needed to build P4 infrastructure."""
    if not native.existing_rule("com_github_bazelbuild_buildtools"):
        http_archive(
            name = "com_github_bazelbuild_buildtools",
            sha256 = "e3bb0dc8b0274ea1aca75f1f8c0c835adbe589708ea89bf698069d0790701ea3",
            strip_prefix = "buildtools-5.1.0",
            url = "https://github.com/bazelbuild/buildtools/archive/refs/tags/5.1.0.tar.gz",
        )
    if not native.existing_rule("com_github_nelhage_rules_boost"):
        # This version includes the fix for boost failures due to the xz library issue.
        http_archive(
            name = "com_github_nelhage_rules_boost",
            url = "https://github.com/nelhage/rules_boost/archive/5160325dbdc8c9e499f9d9917d913f35f1785d52.zip",
            strip_prefix = "rules_boost-5160325dbdc8c9e499f9d9917d913f35f1785d52",
            sha256 = "feb4b1294684c79df7c1e08f1aec5da0da52021e33db59c88edbe86b4d1a017a",
            patch_args = ["-p1"],
            patches = [
                "@com_google_gutil//:bazel/patches/boost-001-temp_fix_for_build_failure.patch",
            ],
        )
    if not native.existing_rule("com_github_grpc_grpc"):
        http_archive(
            name = "com_github_grpc_grpc",
            url = "https://github.com/grpc/grpc/archive/v1.63.0.zip",
            strip_prefix = "grpc-1.63.0",
            sha256 = "daa1b06a19b5f7e4603e1f8980eeab43cf69b6e89bee3b2547f275fa5af7f480",
            patch_args = ["-p1"],
            # TODO(b/411119415): This patch will be removed once we switch over to bzlmod and
            # upgrade the grpc version.
            patches = [
                "@com_google_gutil//:bazel/patches/grpc-003-fix_go_gazelle_register_toolchain.patch",
            ],
        )
    if not native.existing_rule("com_google_absl"):
        http_archive(
            name = "com_google_absl",
            url = "https://github.com/abseil/abseil-cpp/archive/20240116.2.tar.gz",
            strip_prefix = "abseil-cpp-20240116.2",
            sha256 = "733726b8c3a6d39a4120d7e45ea8b41a434cdacde401cba500f14236c49b39dc",
        )
    if not native.existing_rule("com_google_googletest"):
        http_archive(
            name = "com_google_googletest",
            urls = ["https://github.com/google/googletest/archive/release-1.11.0.tar.gz"],
            strip_prefix = "googletest-release-1.11.0",
            sha256 = "b4870bf121ff7795ba20d20bcdd8627b8e088f2d1dab299a031c1034eddc93d5",
        )
    if not native.existing_rule("com_google_benchmark"):
        http_archive(
            name = "com_google_benchmark",
            urls = ["https://github.com/google/benchmark/archive/v1.5.4.tar.gz"],
            strip_prefix = "benchmark-1.5.4",
            sha256 = "e3adf8c98bb38a198822725c0fc6c0ae4711f16fbbf6aeb311d5ad11e5a081b5",
        )
    if not native.existing_rule("com_google_protobuf"):
        http_archive(
            name = "com_google_protobuf",
            url = "https://github.com/protocolbuffers/protobuf/archive/refs/tags/v25.2.zip",
            strip_prefix = "protobuf-25.2",
            sha256 = "ddd0f5271f31b549efc74eb39061e142132653d5d043071fcec265bd571e73c4",
        )
    if not native.existing_rule("com_google_googleapis"):
        http_archive(
            name = "com_google_googleapis",
            url = "https://github.com/googleapis/googleapis/archive/f405c718d60484124808adb7fb5963974d654bb4.zip",
            strip_prefix = "googleapis-f405c718d60484124808adb7fb5963974d654bb4",
            sha256 = "406b64643eede84ce3e0821a1d01f66eaf6254e79cb9c4f53be9054551935e79",
        )
    if not native.existing_rule("com_google_gutil"):
        http_archive(
            name = "com_google_gutil",
            # Newest commit on main as of 2025-07-01.
            url = "https://github.com/google/gutil/archive/4904fcbed388703c581ddcac529e574785386769.zip",
            strip_prefix = "gutil-4904fcbed388703c581ddcac529e574785386769",
            sha256 = "ead4303a3e155149bca23c6ad503a42f664ebce07ffec86f04685b27d4109879",
        )
    if not native.existing_rule("com_github_otg_models"):
        http_archive(
            name = "com_github_otg_models",
            url = "https://github.com/open-traffic-generator/models/archive/refs/tags/v0.12.5.zip",
            strip_prefix = "models-0.12.5",
            build_file = "@//:bazel/BUILD.otg-models.bazel",
            sha256 = "1a63e769f1d7f42c79bc1115babf54acbc44761849a77ac28f47a74567f10090",
        )
    if not native.existing_rule("com_github_gnmi"):
        http_archive(
            name = "com_github_gnmi",
            # v0.10.0 release; commit-hash:5473f2ef722ee45c3f26eee3f4a44a7d827e3575.
            url = "https://github.com/openconfig/gnmi/archive/refs/tags/v0.10.0.zip",
            strip_prefix = "gnmi-0.10.0",
            patch_args = ["-p1"],
            patches = [
                "@com_github_google_pins_infra//:bazel/patches/gnmi-001-fix_virtual_proto_import.patch",
            ],
            sha256 = "2231e1cc398a523fa840810fa6fdb8960639f7b91b57bb8f12ed8681e0142a67",
        )
    if not native.existing_rule("com_github_gnoi"):
        http_archive(
            name = "com_github_gnoi",
            # Newest commit on main on 2021-11-08.
            url = "https://github.com/openconfig/gnoi/archive/1ece8ed91a0d5d283219a99eb4dc6c7eadb8f287.zip",
            strip_prefix = "gnoi-1ece8ed91a0d5d283219a99eb4dc6c7eadb8f287",
            sha256 = "991ff13a0b28f2cdc2ccb123261e7554d9bcd95c00a127411939a3a8c8a9cc62",
        )
    if not native.existing_rule("com_github_p4lang_p4c"):
        http_archive(
            name = "com_github_p4lang_p4c",
            # Newest commit on main on 2024-08-01.
            url = "https://github.com/p4lang/p4c/archive/44dbcda9c7e3d26d24baadb884b31b32d215edef.zip",
            strip_prefix = "p4c-44dbcda9c7e3d26d24baadb884b31b32d215edef",
            sha256 = "ae4d53d0fd41572c38b03e881a8e2d2e472df246f75d6a64555f9ff1b656b574",
        )
    if not native.existing_rule("com_github_p4lang_p4runtime"):
        # We frequently need bleeding-edge, unreleased version of P4Runtime, so we use a commit
        # rather than a release.
        http_archive(
            name = "com_github_p4lang_p4runtime",
            # Newest commit on main as of 2024-11-08.
            urls = ["https://github.com/p4lang/p4runtime/archive/9512a41af6fad2db4a3665b5c893646a31c4b1b4.zip"],
            strip_prefix = "p4runtime-9512a41af6fad2db4a3665b5c893646a31c4b1b4/proto",
            sha256 = "ce6cb01274fa61d219beeb739ed09c460fb2969c74fb94217809f8c26bc9fe06",
        )
    if not native.existing_rule("com_github_p4lang_p4_constraints"):
        http_archive(
            name = "com_github_p4lang_p4_constraints",
            urls = ["https://github.com/p4lang/p4-constraints/archive/5712d1e53c897692d155e0546edfad0baf78eca1.zip"],
            strip_prefix = "p4-constraints-5712d1e53c897692d155e0546edfad0baf78eca1",
            sha256 = "e77bc52271b8d6b740c6141eb53c1882d81839f5d050d7ad71f63abf2efdc1c4",
        )
    if not native.existing_rule("com_jsoncpp"):
        http_archive(
            name = "com_jsoncpp",
            url = "https://github.com/open-source-parsers/jsoncpp/archive/1.9.4.zip",
            strip_prefix = "jsoncpp-1.9.4",
            build_file = "@//:bazel/BUILD.jsoncpp.bazel",
            sha256 = "6da6cdc026fe042599d9fce7b06ff2c128e8dd6b8b751fca91eb022bce310880",
        )
    if not native.existing_rule("com_gnu_gmp"):
        http_archive(
            name = "com_gnu_gmp",
            urls = [
                "https://gmplib.org/download/gmp/gmp-6.2.1.tar.xz",
                "https://ftp.gnu.org/gnu/gmp/gmp-6.2.1.tar.xz",
            ],
            strip_prefix = "gmp-6.2.1",
            sha256 = "fd4829912cddd12f84181c3451cc752be224643e87fac497b69edddadc49b4f2",
            build_file = "@//:bazel/BUILD.gmp.bazel",
        )
    if not native.existing_rule("rules_foreign_cc"):
        http_archive(
            name = "rules_foreign_cc",
            sha256 = "d54742ffbdc6924f222d2179f0e10e911c5c659c4ae74158e9fe827aad862ac6",
            strip_prefix = "rules_foreign_cc-0.2.0",
            url = "https://github.com/bazelbuild/rules_foreign_cc/archive/0.2.0.tar.gz",
        )
    if not native.existing_rule("rules_proto"):
        http_archive(
            name = "rules_proto",
            urls = [
                "https://github.com/bazelbuild/rules_proto/archive/5.3.0-21.7.tar.gz",
            ],
            strip_prefix = "rules_proto-5.3.0-21.7",
            sha256 = "dc3fb206a2cb3441b485eb1e423165b231235a1ea9b031b4433cf7bc1fa460dd",
        )
    if not native.existing_rule("rules_pkg"):
        http_archive(
            name = "rules_pkg",
            urls = [
                "https://mirror.bazel.build/github.com/bazelbuild/rules_pkg/releases/download/0.5.1/rules_pkg-0.5.1.tar.gz",
                "https://github.com/bazelbuild/rules_pkg/releases/download/0.5.1/rules_pkg-0.5.1.tar.gz",
            ],
            sha256 = "a89e203d3cf264e564fcb96b6e06dd70bc0557356eb48400ce4b5d97c2c3720d",
        )
    if not native.existing_rule("com_google_ydf"):
        http_archive(
            name = "com_google_ydf",
            urls = [
                "https://github.com/google/yggdrasil-decision-forests/archive/50e3ef7d8e106f0021cab5fb94b230214f17ff94.zip",
            ],
            strip_prefix = "yggdrasil-decision-forests-50e3ef7d8e106f0021cab5fb94b230214f17ff94",
            sha256 = "c5c0cd9924064a1c70356c2074e30e9fb7daaec6267d33fc58a1d0f4a99bc501",
        )
