-- Telescope opts function. Used as `opts = require "configs.telescope"` in plugin spec.
return function(_, conf)
    conf.defaults = conf.defaults or {}
    conf.pickers = conf.pickers or {}

    -- Skip these for performance on large repos.
    conf.defaults.file_ignore_patterns = {
        ".git/",
        "vendor/",
        "node_modules/",
        "dist/",
        "build/",
        "tmp/",
        "telemetry/",
        "raw_data/",
        "__pycache__/",
        "%.log",
        "%.out",
        "%.test",
        "%.exe",
        "%.dll",
        "%.so",
        "%.db",
        "%.sqlite",
        ".DS_Store",
    }

    conf.pickers.find_files = {
        hidden = true, -- show dotfiles like .env, .nvim
        no_ignore = false, -- respect .gitignore
        follow = true, -- follow symlinks
    }

    conf.defaults.layout_config = {
        horizontal = { preview_width = 0.55 },
        vertical = { preview_height = 0.5 },
    }

    return conf
end
