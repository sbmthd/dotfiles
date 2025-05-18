alias v = nvim
use ~/.cache/starship/init.nu
$env.config.show_banner = false
$env.config.buffer_editor = "nvim"
$env.PATH = ($env.PATH | append ($env.HOME + "/.local/bin"))
$env.PATH = ($env.PATH | prepend "/usr/local/bin")
$env.PATH = ($env.PATH | prepend ['/opt/homebrew/bin' '/opt/homebrew/sbin'])
