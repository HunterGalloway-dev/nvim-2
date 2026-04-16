return {
    cmd = { "bash-language-server", "start" },
    -- 'bash' covers files with #!/bin/bash shebang; 'sh' covers generic shell scripts
    filetypes = { "sh", "bash" },
}
