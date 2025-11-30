return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
  },
  config = function()
    local cmp_nvim_lsp = require("cmp_nvim_lsp")
    local capabilities = cmp_nvim_lsp.default_capabilities()

    -- same <leader>gf mapping you had
    vim.keymap.set("n", "<leader>gf", function()
      local component = vim.fn.expand("<cword>")
      local buf_lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
      local import_path = nil

      for _, line in ipairs(buf_lines) do
        local default_match = line:match("import%s+" .. component .. "%s+from%s+[\"'](.-)[\"']")
        local named_match = line:match("import%s+{[^}]*" .. component .. "[^}]*}%s+from%s+[\"'](.-)[\"']")
        if default_match then
          import_path = default_match
          break
        elseif named_match then
          import_path = named_match
          break
        end
      end

      if not import_path then
        print("Cannot find import path for " .. component)
        return
      end

      local current_dir = vim.fn.expand("%:p:h")
      if import_path:sub(1, 2) == "@/" then
        import_path = vim.fn.getcwd() .. "/src/" .. import_path:sub(3)
      elseif import_path:sub(1, 1) ~= "/" then
        import_path = current_dir .. "/" .. import_path
      end

      local candidates = {
        import_path .. ".tsx",
        import_path .. ".ts",
        import_path .. ".jsx",
        import_path .. ".js",
        import_path .. "/index.tsx",
        import_path .. "/index.ts",
        import_path .. "/index.jsx",
        import_path .. "/index.js",
      }

      local target_file = nil
      for _, f in ipairs(candidates) do
        if vim.fn.filereadable(f) == 1 then
          target_file = f
          break
        end
      end

      if not target_file then
        print("Cannot find file for " .. component)
        return
      end

      local tried = {}
      while target_file:match("index%.") do
        if tried[target_file] then
          break
        end
        tried[target_file] = true

        local lines = {}
        for line in io.lines(target_file) do
          table.insert(lines, line)
        end

        local found = false
        for _, line in ipairs(lines) do
          local reexport = line:match("export%s+{[^}]*" .. component .. "[^}]*}%s+from%s+['\"](.-)['\"]")
          if reexport then
            local dir = vim.fn.fnamemodify(target_file, ":h")
            local reexport_candidates = {
              dir .. "/" .. reexport .. ".tsx",
              dir .. "/" .. reexport .. ".ts",
              dir .. "/" .. reexport .. ".jsx",
              dir .. "/" .. reexport .. ".js",
            }
            for _, rf in ipairs(reexport_candidates) do
              if vim.fn.filereadable(rf) == 1 then
                target_file = rf
                found = true
                break
              end
            end
          end

          if line:match("export%s+default%s+" .. component) then
            for _, imp in ipairs(lines) do
              local imp_path = imp:match("import%s+" .. component .. "%s+from%s+[\"'](.-)[\"']")
              if imp_path then
                local dir = vim.fn.fnamemodify(target_file, ":h")
                local reexport_candidates = {
                  dir .. "/" .. imp_path .. ".tsx",
                  dir .. "/" .. imp_path .. ".ts",
                  dir .. "/" .. imp_path .. ".jsx",
                  dir .. "/" .. imp_path .. ".js",
                }
                for _, rf in ipairs(reexport_candidates) do
                  if vim.fn.filereadable(rf) == 1 then
                    target_file = rf
                    found = true
                    break
                  end
                end
              end
              if found then
                break
              end
            end
          end

          local star = line:match("export%s+%*%s+from%s+['\"](.-)['\"]")
          if star and line:find(component) then
            local dir = vim.fn.fnamemodify(target_file, ":h")
            local reexport_candidates = {
              dir .. "/" .. star .. ".tsx",
              dir .. "/" .. star .. ".ts",
              dir .. "/" .. star .. ".jsx",
              dir .. "/" .. star .. ".js",
            }
            for _, rf in ipairs(reexport_candidates) do
              if vim.fn.filereadable(rf) == 1 then
                target_file = rf
                found = true
                break
              end
            end
          end

          if found then
            break
          end
        end

        if not found then
          break
        end
      end

      vim.cmd("edit " .. target_file)
      vim.cmd("/\\v(function|const|export).*" .. component)
    end, { noremap = true, silent = true })

    -- per-server config using native 0.11 API
    vim.lsp.config("ts_ls", {
      capabilities = capabilities,
      on_attach = function(client, bufnr)
        vim.diagnostic.open_float()
        vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
          border = "rounded",
        })
      end,
    })

    vim.lsp.config("cssls", {
      capabilities = capabilities,
    })

    vim.lsp.config("astro", {
      capabilities = capabilities,
      filetypes = { "astro" },
      -- if you had a global `on_attach`, you can still add it here
    })

    vim.lsp.enable({ "ts_ls", "cssls", "astro" })
  end,
}
