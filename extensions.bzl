load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository", "new_git_repository")

def _non_module_dependencies_impl(_ctx):
    git_repository(
        name = "io_bazel",
        commit = "4853dfd02ac7440a04caada830b7b61b6081bdfe",  # 2023-01-11
        remote = "https://github.com/bazelbuild/bazel.git",
        shallow_since = "1673450740 -0800",
    )
    new_git_repository(
        name = "starlark-rust",
        branch = "main",
        build_file_content = """
    genrule(
        name = "starlark",
        outs = ["target/debug/starlark-repl"],
        srcs = ["."],
        cmd = "cd $(SRCS) && cargo build && cd - && cp $(SRCS)/target/debug/starlark $@",
        executable = True,
        local = True,
        visibility = ["//visibility:public"],
    )
    """,
        remote = "https://github.com/facebookexperimental/starlark-rust.git",
    )

non_module_dependencies = module_extension(
    implementation = _non_module_dependencies_impl,
)
