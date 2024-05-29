local config = {
  cmd = {
    "/Users/darren/.local/share/nvim/mason/bin/jdtls",
    "--jvm-arg=-javaagent:/Users/darren/.local/share/nvim/mason/share/jdtls/lombok.jar",
  },
  root_dir = vim.fs.dirname(vim.fs.find({ "gradlew", ".git", "mvnw" }, { upward = true })[1]),
}
require("jdtls").start_or_attach(config)
