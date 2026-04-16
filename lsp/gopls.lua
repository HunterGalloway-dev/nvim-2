return {
    -- Use the gopls built from source against the local Go toolchain
    -- (`go install golang.org/x/tools/gopls@latest`) instead of the Mason copy,
    -- which lags behind the current Go release and ships an outdated modernize.
    cmd = { vim.fn.expand "~/go/bin/gopls" },
    filetypes = { "go", "gomod", "gotmpl", "gowork" },
    settings = {
        gopls = {
            gofumpt = true,
            staticcheck = true,
            hoverKind = "FullDocumentation",
            -- Library-friendly workspace behavior. Ensures every package in
            -- the module is analyzed even if no main package imports it.
            expandWorkspaceToModule = true,
            -- Keep "Hint" severity diagnostics (where modernize lives) even
            -- in files that aren't currently transitively reachable.
            diagnosticsTrigger = "Edit",
            diagnosticsDelay = "250ms",
            -- Completions: pull from packages you haven't imported yet, drop
            -- argument placeholders into function calls, and offer postfix
            -- completions like `x.if` -> `if x { ... }`.
            completeUnimported = true,
            usePlaceholders = true,
            experimentalPostfixCompletions = true,
            -- Scan module dependencies for known CVEs against the Go vuln DB.
            -- "Imports" is the lighter mode (compare to "Off" or full "Lazy").
            vulncheck = "Imports",
            -- Code lenses surface gopls-driven actions inline above declarations.
            codelenses = {
                generate = true, -- run `go generate`
                test = true, -- run/debug single test or benchmark
                tidy = true, -- run `go mod tidy`
                upgrade_dependency = true, -- check for module upgrades
                vendor = true,
                regenerate_cgo = true,
                gc_details = false,
            },
            analyses = {
                unusedparams = true,
                shadow = true,
                unreachable = true,
                nilness = true,
                printf = true,
                httpresponse = true,
                lostcancel = true,
                loopclosure = true,
                waitgroup = true,
                timeformat = true,
                testinggoroutine = true,
                -- Suggests Go 1.21+ idioms: `any` over `interface{}`,
                -- `min`/`max` builtins, `slices.Contains`, `clear()` for maps,
                -- `for range int` (1.22+), `errors.Is/As`, etc.
                -- Offered as code actions — apply with <leader>ca.
                modernize = true,
                -- Catches unused writes to fields/locals.
                unusedwrite = true,
                -- Flags context.Context that's never cancelled or passed on.
                unusedresult = true,
                -- staticcheck SA-series style suggestions (receiver naming, etc.)
                ST1020 = true,
                ST1021 = true,
                ST1022 = true,
            },
            -- Inlay hints disabled — too noisy on large Go files. Modernize
            -- diagnostics (any over interface{}, slices.Contains, etc.) live
            -- in `analyses` above and are unaffected by this.
            hints = {
                assignVariableTypes = false,
                compositeLiteralFields = false,
                compositeLiteralTypes = false,
                constantValues = false,
                functionTypeParameters = false,
                parameterNames = false,
                rangeVariableTypes = false,
            },
        },
    },
}
