load("local_genrule.bzl", "local_genrule")
load("@rules_python//python:defs.bzl", "py_runtime_pair", "py_binary")

py_binary(
  name = "py_script",
  srcs = ["script.py"],
  main = "script.py",
  python_version = "PY3",
  srcs_version = "PY3",
  exec_compatible_with = [":local_value"],
)

local_genrule(
  name = "local",
  exec_tool = "//:py_script",
  out = "local_version.txt",
)

constraint_setting(
    name = "local_setting"
)

constraint_value(
    name = "local_value",
    constraint_setting = ":local_setting",
)

platform(
  name = "local_platform",
  constraint_values = [
    "@platforms//os:linux",
    "@platforms//cpu:x86_64",
    ":local_value",
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
    name = "local_toolchain",
    target_compatible_with = [":local_value" ],
    exec_compatible_with = [":local_value" ],
    toolchain = ":local_runtime",
    toolchain_type = "@bazel_tools//tools/python:toolchain_type",
)

py_binary(
    name = "remote_script",
    srcs = ["script.py"],
    main = "script.py",
    python_version = "PY3",
    srcs_version = "PY3",
)

genrule(
  name = "remote",
  cmd = "$(location //:remote_script) $@",
  outs = ["remote_version.txt"],
  exec_tools = ["//:remote_script"],
)

constraint_setting(
    name = "remote_setting"
)

constraint_value(
    name = "remote_value",
    constraint_setting = ":remote_setting",
)

platform(
  name = "remote_platform",
  constraint_values = [
    "@platforms//os:linux",
    "@platforms//cpu:x86_64",
    ":remote_value",
  ],
  exec_properties = {
      "Pool": "default",
      "container-image": "docker://",
      },
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
    name = "remote_toolchain",
    target_compatible_with = [":remote_value" ],
    exec_compatible_with = [":remote_value" ],
    toolchain = ":remote_runtime",
    toolchain_type = "@bazel_tools//tools/python:toolchain_type",
)

