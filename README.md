# Neovim Configuration

Built on NvChad v2.5 as a base. This config is oriented around backend microservice development in Go, data infrastructure (Kafka, MongoDB, SQL), Kubernetes operations, and a React frontend stack. It is not a general-purpose setup — every tool here was added for a specific reason.

Plugin management is handled by lazy.nvim. All language servers, formatters, and linters are installed and kept up to date automatically through mason-tool-installer, which runs a check on startup once per day.

---

## Prerequisites

These need to be installed on your system before the config will work correctly. Mason handles everything inside Neovim, but it cannot install its own runtime dependencies.

**Required:**

- Neovim 0.11 or later. This config uses `vim.lsp.config` and `vim.lsp.enable` which are 0.11-only APIs. Earlier versions will not work.
- Git. Required for lazy.nvim to bootstrap itself and download plugins.
- A C compiler (gcc or clang). Treesitter compiles parsers from source on first install.
- Node.js 18 or later. A large number of Mason packages are Node-based: the TypeScript LSP, JSON LSP, YAML LSP, HTML LSP, CSS LSP, Dockerfile LSP, Emmet, and others.
- Go 1.21 or later. Required for gopls, gofumpt, goimports, go.nvim, and Delve.
- ripgrep. Required for Telescope live grep. Install via `brew install ripgrep` or your system package manager.
- A Nerd Font installed and set as your terminal font. The UI uses Nerd Font glyphs for file icons and status indicators. Recommended: JetBrainsMono Nerd Font or Meslo Nerd Font.

**Recommended:**

- lazygit. The `<leader>lg` binding opens LazyGit in a floating terminal. Without it the binding does nothing. Install via `brew install lazygit`.
- fd. Improves Telescope file search performance. Install via `brew install fd`.
- make. Required to build some plugins that have a `build` step.

**Verify your versions:**

```sh
nvim --version      # should be 0.11+
node --version      # should be 18+
go version          # should be 1.21+
rg --version        # ripgrep
gcc --version       # or clang --version
```

---

## Installation

**1. Back up your existing config if you have one:**

```sh
mv ~/.config/nvim ~/.config/nvim.bak
mv ~/.local/share/nvim ~/.local/share/nvim.bak
```

**2. Clone this repo:**

```sh
git clone https://github.com/YOUR_USERNAME/YOUR_REPO ~/.config/nvim
```

**3. Start Neovim:**

```sh
nvim
```

On first launch, lazy.nvim bootstraps itself and then installs all plugins. This takes a minute or two depending on your connection. You will see a progress UI. Let it finish completely before doing anything.

**4. Let Mason install the tooling:**

Mason tool installer runs automatically in the background after plugins load (it fires on the `VeryLazy` event). The first run installs every language server, formatter, and linter in one pass. You can watch the progress with `:Mason`.

After the initial install, Mason checks for missing tools once per day on startup. If you add a new tool to the `ensure_installed` list in `lua/plugins/init.lua`, it will be installed the next time Neovim starts.

**5. Restart Neovim:**

After the initial install completes, restart Neovim once. Treesitter parsers and some LSP servers need a clean session to initialize correctly.

**First launch checklist:**

- Run `:checkhealth` to verify there are no critical issues
- Open a `.go` file and confirm gopls attaches (`:LspInfo`)
- Open a `.ts` or `.tsx` file inside a project and confirm ts_ls attaches
- Run `:ConformInfo` in any buffer to verify the expected formatters show as ready

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

vtsls handles type checking, go-to-definition, auto-imports, and completions for TypeScript and JSX/TSX files. It is a thin wrapper around the same `tsserver` used by VS Code, with lower memory overhead and better LSP feature parity than the older `typescript-language-server`. Inlay hints are enabled for parameter names (literals only) and function return types. Variable type hints are off since they add too much noise in React component code.

Biome is the formatter and linter for projects that have a `biome.json` at the root. It runs as both an LSP (real-time diagnostics) and a formatter on save. For projects without Biome, Prettier handles formatting as a fallback. This means Go projects and other non-JS codebases are not affected by Biome at all.

The Biome formatter condition checks upward from the current file for a `biome.json` before running, so it will not silently fail on files outside a Biome project.

Emmet is available for JSX and HTML files for tag expansion.

### SQL

sqls provides completions and basic intelligence for SQL files. sql-formatter runs on save with uppercase keywords and 4-space indentation.

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

## Diagnostics

Trouble provides a workspace-level diagnostics panel that aggregates errors and warnings across all open files.

The prefix is `<leader>X` (capital) to avoid colliding with NvChad's `<leader>x` "close buffer" mapping.

| Key | Action |
|---|---|
| `<leader>Xx` | Workspace diagnostics |
| `<leader>Xb` | Current buffer diagnostics |
| `<leader>Xs` | Symbols panel |
| `<leader>Xl` | Location list |
| `<leader>Xq` | Quickfix list |

Direct LSP code actions are on `<leader>ca`. Peek definition and peek type definition are on `gpd` and `gpt` respectively via Glance.

---

## Git

LazyGit opens in a floating terminal on `<leader>lg`. Gitsigns provides gutter indicators for added, changed, and removed lines, plus inline current-line blame at the end of each line (author, date, summary, SHA) after a 300ms cursor pause.

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

## Configuration Layout

```
~/.config/nvim/
├── init.lua                # bootstrap (lazy, base46 cache, version guard)
├── lsp/                    # one file per LSP server (Neovim 0.11+ auto-loader)
│   ├── gopls.lua
│   ├── pyright.lua
│   ├── vtsls.lua
│   └── ...
└── lua/
    ├── chadrc.lua          # NvChad theme & UI overrides
    ├── options.lua         # vim options
    ├── mappings.lua        # all custom keybindings
    ├── autocmds.lua        # filetype detection, inlay-hint LspAttach hook, etc.
    ├── configs/
    │   ├── lazy.lua        # lazy.nvim setup
    │   ├── conform.lua     # formatters
    │   ├── lint.lua        # nvim-lint linters
    │   ├── dap.lua         # DAP UI layout + listeners
    │   └── telescope.lua   # Telescope opts
    └── plugins/
        ├── init.lua        # imports the domain files below
        ├── lsp.lua         # mason, lspconfig, schemastore, Glance
        ├── completion.lua  # blink.cmp via NvChad's bundled spec
        ├── treesitter.lua  # treesitter + treesitter-context
        ├── editor.lua      # telescope, conform, nvim-lint, trouble
        ├── git.lua         # lazygit, gitsigns inline blame
        ├── dap.lua         # nvim-dap, dap-ui, dap-go, dap-python, dap-virtual-text
        └── lang-go.lua     # ray-x/go.nvim (slimmed)
```

---

## Adding Support for a New Language

1. Add the LSP server and any formatter / linter tools to the `ensure_installed` list under mason-tool-installer in `lua/plugins/lsp.lua`. They will auto-install on next startup.
2. Create `~/.config/nvim/lsp/<server_name>.lua` returning the server's config table, then add the server name to the `vim.lsp.enable {...}` list in `lua/plugins/lsp.lua`.
3. Add the formatter to `lua/configs/conform.lua` under `formatters_by_ft`. If the formatter needs custom arguments, add a block under `formatters`.
4. If the language needs a linter that runs outside the LSP, add it to `lint.linters_by_ft` in `lua/configs/lint.lua`.
5. Add a treesitter parser to the `ensure_installed` list in `lua/plugins/treesitter.lua` if one exists for the language.
6. If Neovim does not detect the filetype correctly (check with `:set ft?`), add the extension or filename to `vim.filetype.add` in `lua/autocmds.lua`.
