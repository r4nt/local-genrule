load("local_genrule.bzl", "local_genrule")
load("@rules_python//python:defs.bzl", "py_runtime_pair", "py_binary")

py_binary(
  name = "py_script",
  srcs = ["script.py"],
  main = "script.py",
  python_version = "PY3",
  srcs_version = "PY3",
)

local_genrule(
  name = "local",
  exec_tool = "//:py_script",
  out = "local_version.txt",
)

genrule(
  name = "remote",
  cmd = "$(location //:py_script) $@",
  outs = ["remote_version.txt"],
  exec_tools = ["//:py_script"],
)

constraint_value(
    name = "local_python",
    constraint_setting = "@bazel_tools//tools/python:py3_interpreter_path",
)

platform(
  name = "local_platform",
  constraint_values = [
    "@platforms//os:linux",
    "@platforms//cpu:x86_64",
    ":local_python",
  ],
)

py_runtime(
    name = "local_py3_runtime",
    interpreter_path = "/usr/bin/python3.7",
    python_version = "PY3",
)

py_runtime_pair(
    name = "local_runtime",
    py3_runtime = ":local_py3_runtime",
)

toolchain(
    name = "local_python_toolchain",
    target_compatible_with = [
        ":local_python",
    ],
    toolchain = ":local_runtime",
    toolchain_type = "@bazel_tools//tools/python:toolchain_type",
)

py_runtime(
    name = "remote_py3_runtime",
    interpreter_path = "/usr/bin/python3.6",
    python_version = "PY3",
)

py_runtime_pair(
    name = "remote_runtime",
    py3_runtime = ":remote_py3_runtime",
)

toolchain(
    name = "remote_python_toolchain",
    toolchain = ":remote_runtime",
    toolchain_type = "@bazel_tools//tools/python:toolchain_type",
)

