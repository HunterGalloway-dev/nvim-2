# Neovim Configuration

Built on NvChad v2.5 as a base. This config is oriented around backend microservice development in Go, data infrastructure (Kafka, MongoDB, SQL), Kubernetes operations, and a React frontend stack. It is not a general-purpose setup — every tool here was added for a specific reason.

Plugin management is handled by lazy.nvim. All language servers, formatters, and linters are installed and kept up to date automatically through mason-tool-installer, which runs a check on startup once per day.

---

## Languages and Tooling

### Go

The primary language. gopls is configured with staticcheck enabled, full hover documentation, and inlay hints covering parameter names, composite literal fields, type parameters, and range variables. gofumpt and goimports run on save.

go.nvim adds editor-level commands for common Go patterns: inserting `if err != nil` blocks, adding and removing JSON/BSON struct tags. The debug setup uses Delve via nvim-dap with a minimal UI (scopes, breakpoints, console only) that opens and closes automatically when a session starts and ends.

| Key | Action |
|---|---|
| `<leader>ge` | Insert if err != nil |
| `<leader>gjt` | Add JSON struct tags |
| `<leader>gbt` | Add BSON struct tags |
| `<leader>gjr` | Remove JSON struct tags |
| `<leader>gbr` | Remove BSON struct tags |
| `<leader>gdd` | Launch debugger |
| `<leader>gdb` | Toggle breakpoint |
| `<leader>gdt` | Debug current test |
| `<leader>gds` | Stop debug session |
| `<leader>tgb` | Run test file (verbose) |
| `<leader>tgf` | Run test function (verbose) |

### TypeScript / React

ts_ls handles type checking, go-to-definition, auto-imports, and completions for TypeScript and JSX/TSX files. Inlay hints are enabled for parameter names (literals only) and function return types. Variable type hints are off since they add too much noise in React component code.

Biome is the formatter and linter for projects that have a `biome.json` at the root. It runs as both an LSP (real-time diagnostics) and a formatter on save. For projects without Biome, Prettier handles formatting as a fallback. This means Go projects and other non-JS codebases are not affected by Biome at all.

The Biome formatter condition checks upward from the current file for a `biome.json` before running, so it will not silently fail on files outside a Biome project.

Emmet is available for JSX and HTML files for tag expansion.

### SQL

sqls provides completions and basic intelligence for SQL files. sql-formatter runs on save with uppercase keywords and 4-space indentation. For executing queries directly against live databases, vim-dadbod provides a UI that supports MongoDB, PostgreSQL, MySQL, and SQLite connections.

| Key | Action |
|---|---|
| `<leader>db` | Toggle database UI |
| `<leader>da` | Add a new connection |
| `<leader>df` | Find an existing DB buffer |

Connections are stored locally and persist across sessions. Connect using a standard connection string (e.g. `mongodb://localhost:27017/mydb` or `postgresql://user:pass@host/db`).

### Kubernetes and Helm

yamlls is configured with schemastore, which provides automatic schema validation and completions for Kubernetes manifests, Helm values files, GitHub Actions, Docker Compose, and most other common YAML formats. No manual schema configuration is needed.

helm-ls attaches to Helm chart templates and integrates with yamlls for the underlying YAML handling.

### Docker

dockerls and docker-compose-language-service provide completions and validation for Dockerfiles and Compose files. No standalone formatter is configured for Dockerfiles since the LSP handles formatting via the standard format-on-save fallback.

hadolint runs via nvim-lint on save and after leaving insert mode. It catches best practice violations, missing version pins, unnecessary instructions, and shell script errors inside RUN instructions that the LSP does not report.

### Shell

bashls provides completions and basic intelligence for shell scripts. shellcheck runs on every save and after leaving insert mode via nvim-lint, surfacing warnings and errors as inline diagnostics.

### Starlark

Used for ETL transform scripts running in a custom Go engine, not for Bazel. The Bazel-specific LSP (starpls) is intentionally excluded because it does not understand custom module environments and would produce false errors for engine-provided modules like `json`.

buildifier handles formatting and syntax validation. It runs on save and also through nvim-lint for real-time diagnostics. Treesitter provides syntax highlighting.

Filetype detection covers `.star` files as well as standard Bazel filenames (BUILD, WORKSPACE, MODULE.bazel) if they appear.

### Data Formats

JSON files get schema validation through jsonls with the full schemastore catalog. Files that allow comments (tsconfig.json, .eslintrc.json, devcontainer.json, VSCode workspace files) are detected as `jsonc` and handled accordingly. Biome formats JSON in Biome projects, Prettier otherwise.

YAML validation uses schemastore automatically. Prettier handles YAML formatting.

---

## HTTP API Testing

Kulala lets you write and run HTTP requests from `.http` files directly in the editor. Useful for testing microservice endpoints without switching to a separate tool.

| Key | Action |
|---|---|
| `<leader>hr` | Run the request under the cursor |
| `<leader>hn` | Jump to next request in file |
| `<leader>hp` | Jump to previous request |
| `<leader>hi` | Inspect the request |

---

## Diagnostics

Trouble provides a workspace-level diagnostics panel that aggregates errors and warnings across all open files.

| Key | Action |
|---|---|
| `<leader>xx` | Workspace diagnostics |
| `<leader>xb` | Current buffer diagnostics |
| `<leader>xs` | Symbols panel |
| `<leader>xl` | Location list |
| `<leader>xq` | Quickfix list |

Direct LSP code actions are on `<leader>ca`. Peek definition and peek type definition are on `gpd` and `gpt` respectively via lspsaga.

---

## Git

LazyGit opens in a floating terminal on `<leader>lg`. Git blame virtual text shows inline on each line showing the commit summary, date, author, and SHA. Gitsigns provides gutter indicators for added, changed, and removed lines.

---

## Navigation and Search

Telescope is the primary search interface. File search shows hidden files and follows symlinks but excludes vendor directories, node_modules, build artifacts, compiled binaries, and log files. Preview width is set to 55% on horizontal layouts.

Treesitter context pins the current function or block header at the top of the screen as you scroll through long functions, which is particularly useful when working in large Go service files.

---

## Linting Summary

| Language | Linter | Mechanism |
|---|---|---|
| Go | staticcheck | via gopls |
| TypeScript / JavaScript | Biome | via Biome LSP (requires biome.json) |
| Shell | shellcheck | via nvim-lint |
| Starlark | buildifier | via nvim-lint |
| SQL | sqls | via sqls LSP |
| YAML | yaml-language-server | via LSP |
| Docker | hadolint | via nvim-lint |

---

## Formatting Summary

| Language | Formatter | Notes |
|---|---|---|
| Go | gofumpt + goimports | always |
| TypeScript / JavaScript / JSON / CSS | Biome | when biome.json present |
| TypeScript / JavaScript / JSON / CSS | Prettier | fallback when no biome.json |
| HTML / Markdown | Prettier | always (Biome does not cover these) |
| YAML | Prettier | always |
| SQL | sql-formatter | uppercase keywords, 4-space indent |
| Shell | shfmt | 4-space indent, case indented |
| Starlark | buildifier | always |
| Lua | stylua | always |

All formatters run on save with a 2000ms timeout. If no dedicated formatter is configured for a filetype, the LSP formatting provider is used as a fallback.

---

## Adding Support for a New Language

1. Add the LSP server and any formatter / linter tools to the `ensure_installed` list in `lua/plugins/init.lua` under mason-tool-installer. They will auto-install on next startup.
2. Add the LSP config block to `lua/configs/lspconfig.lua` and include the server name in the `vim.lsp.enable(servers)` list at the bottom.
3. Add the formatter to `lua/configs/conform.lua` under `formatters_by_ft`. If the formatter needs custom arguments, add a block under `formatters`.
4. If the language needs a linter that runs outside the LSP, add it to the `lint.linters_by_ft` table in the nvim-lint plugin block in `lua/plugins/init.lua`.
5. Add a treesitter parser to the `ensure_installed` list in the treesitter plugin block if one exists for the language.
6. If Neovim does not detect the filetype correctly (check with `:set ft?`), add the extension or filename to `vim.filetype.add` in `lua/autocmds.lua`.
