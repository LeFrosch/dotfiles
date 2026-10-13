local ensure_installed = {
  'codespell',
}

require('mason').setup {
  ui = {
    border = 'rounded'
  }
}

local registry = require('mason-registry')
registry.refresh(function()
  for _, name in ipairs(ensure_installed) do
    local pkg = registry.get_package(name)
    if not pkg:is_installed() then
      pkg:install()
    end
  end
end)
