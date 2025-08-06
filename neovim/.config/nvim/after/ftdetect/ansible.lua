-- Originally nabbed from:
-- https://github.com/mfussenegger/nvim-ansible/blob/main/ftdetect/ansible.lua
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  desc = "Set filetype for Ansible yaml files",
  pattern = {
    "*/{ansible,defailts,host_vars,group_vars,playbook,playbooks,tasks,molecule}/*.{yml,yaml}",
    "*/roles/*/{tasks,handlers}/*.{yml,yaml}",
  },
  command = "setlocal filetype=yaml.ansible",
})
