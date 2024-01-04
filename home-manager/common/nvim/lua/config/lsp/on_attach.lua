local builtin = require("telescope.builtin")

return function(options)
  return function(client, bufnr)
    local nmap = function(keys, func, desc)
      vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
    end
    vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"

    nmap("gi", vim.lsp.buf.implementation, "Implementation")
    nmap("gd", vim.lsp.buf.definition, "Definition")
    nmap("gr", builtin.lsp_references, "References")
    nmap("gt", vim.lsp.buf.type_definition, "Type definition")
    nmap("gD", vim.lsp.buf.declaration, "Declaration")

    nmap("K", vim.lsp.buf.hover, "Hover Documentation")
    nmap("[d", vim.diagnostic.goto_prev, "Diagnostics: Go to Previous")
    nmap("]d", vim.diagnostic.goto_next, "Diagnostics: Go to Next")

    nmap("<leader>fx", vim.lsp.buf.signature_help, "Signature Documentation")
    nmap("<leader>ft", builtin.treesitter, "Treesitter")
    nmap("<leader>fs", builtin.lsp_document_symbols, "Document symbols")
    nmap("<leader>cr", vim.lsp.buf.rename, "Rename")
    nmap("<leader>ca", vim.lsp.buf.code_action, "Code Action")

    if client.name == "ruff-lsp" then
      client.server_capabilities.hoverProvider = false
    end
  end
end
