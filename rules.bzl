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

def _pkg_msi_impl(ctx):
    obj = ctx.actions.declare_file(ctx.label.name + ".obj")
    out = ctx.actions.declare_file(ctx.label.name)

    my_deps = []
    for x in ctx.attr.deps:
        my_deps += x.files.to_list()
    ctx.actions.run(
        outputs = [obj],
        inputs = [ctx.file.src] + my_deps,
        executable = ctx.executable._candle,
        arguments = [
            "-nologo",
            "-arch", ctx.attr.arch,
            "-o", obj.path,
            ctx.file.src.path],
    )

    exts = []
    for x in ctx.attr.exts:
        exts += ["-ext", x]

    ctx.actions.run(
        outputs = [out],
        inputs = [obj],
        executable = ctx.executable._light,
        arguments = ["-nologo"] + exts + ["-out", out.path, obj.path],
    )

    return [DefaultInfo(
        files = depset([out]),
    )]

pkg_msi = rule(
    implementation = _pkg_msi_impl,
    attrs = {
        "src" : attr.label(allow_single_file = True),
        "deps" : attr.label_list(allow_files = True),
        "exts" : attr.string_list(),
        "arch" : attr.string(default = "x64"),
        "_candle" : attr.label(
            default = "@com_github_wixtoolset_wix3//:candle",
            allow_single_file = True,
            executable = True,
            cfg = "host",
        ),
        "_light" : attr.label(
            default = "@com_github_wixtoolset_wix3//:light",
            allow_single_file = True,
            executable = True,
            cfg = "host",
        ),
    }
)