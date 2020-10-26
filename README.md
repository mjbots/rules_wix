# WiX Toolset support for Bazel #

This package provides bazel (https://bazel.build) rules for building
Microsoft Windows .msi installers using the WiX Toolset.

* License: Apache 2.0

## Usage ##

In `WORKSPACE` add this:

```
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

RULES_WIX_COMMIT = "XXX"

http_archive(
    name = "rules_wix",
    url = "https://github.com/mjbots/rules_wix/{}.zip".format(RULES_WIX_COMMIT),

    # Replace this with the value from the bazel error message.
    sha256 = "0000000000000000000000000000000000000000000000000000000000000000",

    strip_prefix = "rules_wix-{}".format(RULES_WIX_COMMIT),
)

load("@rules_wix//:deps.bzl", "add_wix_deps")
add_wix_deps()
```

Then in a BUILD file you can use:

```
load("@rules_wix//:rules.bzl", "pkg_msi")

pkg_msi(
  name = "example.msi",
  src = "example.wxs",
  deps = [
    # ...
  ],
  arch = "x64",
  exts = [
    "WixUiExtension",
    # ...
  ],
)
```
