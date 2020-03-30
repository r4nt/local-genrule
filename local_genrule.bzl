def _local_exec_transition_impl(settings, attr):
  return {
    # Use the local platform only for the subgraph
    "//command_line_option:platforms" : [attr._local_platform],
    # Force all targets in the subgraph to build on the local machine
    "//command_line_option:modify_execution_info" : ".*=+no-remote-exec"
  }

_local_exec_transition = transition(
  implementation = _local_exec_transition_impl,
  inputs = [],
  outputs = ["//command_line_option:platforms", "//command_line_option:modify_execution_info"],
)

def _impl(ctx):
  ctx.actions.run(
    outputs = [ctx.outputs.out],
    arguments = [ctx.outputs.out.path],
    executable = ctx.attr.exec_tool[0][DefaultInfo].files_to_run,
    execution_requirements = {"no-remote-exec" : ""},
  )

_local_genrule = rule(
  implementation = _impl,
  attrs = {
    'out' : attr.output(),
    'exec_tool' : attr.label(cfg = _local_exec_transition),
    '_local_platform' : attr.label(default = "@//:local_platform"),
    "_whitelist_function_transition": attr.label(default = "@bazel_tools//tools/whitelists/function_transition_whitelist"),
  },
)

def local_genrule(name, out, exec_tool):
  _local_genrule(
    name = name,
    out = out,
    exec_tool = exec_tool,
  )
