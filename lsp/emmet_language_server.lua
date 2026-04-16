-- Emmet: fast JSX/HTML tag expansion (e.g. div.container>ul>li*3)
return {
    cmd = { "emmet-language-server", "--stdio" },
    filetypes = {
        "html",
        "css",
        "javascriptreact",
        "typescriptreact",
    },
    single_file_support = true,
}
