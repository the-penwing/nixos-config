-- ~/.config/nvim/lua/plugins/langs/init.lua
local specs = {}

for _, file in ipairs(vim.fn.globpath(vim.fn.stdpath "config" .. "/lua/plugins/langs", "*.lua", false, true)) do
  local module_name = vim.fn.fnamemodify(file, ":t:r")
  if module_name ~= "init" then
    local module_specs = require("plugins.langs." .. module_name)
    if type(module_specs) == "table" then vim.list_extend(specs, module_specs) end
  end
end

return specs
