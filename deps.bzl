# -*- python -*-

# Copyright 2020 Josh Pieper, jjp@pobox.com.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

def add_wix_deps():
    if not native.existing_rule("com_github_wixtoolset_wix3"):
        http_archive(
            name = "com_github_wixtoolset_wix3",
            urls = ["https://github.com/wixtoolset/wix3/releases/download/wix3112rtm/wix311-binaries.zip"],
            sha256 = "2c1888d5d1dba377fc7fa14444cf556963747ff9a0a289a3599cf09da03b9e2e",
            build_file = Label("//:wix3.BUILD"),
        )