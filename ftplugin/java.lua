-- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
local config = {
  cmd = {
    'java', -- or '/path/to/java11_or_newer/bin/java'
    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-Xms1g',
    '--add-modules=ALL-SYSTEM',
    '--add-opens', 'java.base/java.util=ALL-UNNAMED',
    '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
    '-jar', '/Users/bas/.local/share/nvim/lsp_servers/jdtls/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar',
    '-configuration', '/Users/bas/.local/share/nvim/lsp_servers/jdtls/config_mac',
    '-data', '/Users/bas/.local/share/nvim/lsp_servers/jdtls/data'
  },
  root_dir = require('jdtls.setup').find_root({'.git', 'pom.xml'}),
  settings = {
    java = {
    }
  },
  init_options = {
    bundles = {}
  },
}
require('jdtls').start_or_attach(config)
