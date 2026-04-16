-- Helm LSP (Kubernetes chart templates)
return {
    cmd = { "helm_ls", "serve" },
    filetypes = { "helm" },
    settings = {
        ["helm-ls"] = {
            yamlls = { path = "yaml-language-server" },
        },
    },
}
