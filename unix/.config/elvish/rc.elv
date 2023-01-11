use epm
use re
use path
use str
use math

# Assert elvish version
if (not-eq [(str:split . $version)][..2] [0 18]) {
    fail 'Incompatible elvish version'
}

# Enable plugins
use github.com/zzamboni/elvish-themes/chain

# Configure prompt
chain:init
set chain:prompt-pwd-dir-length = 3

# Paths
set paths = [~/.local/bin $@paths]

# Environment
set E:EDITOR = micro

# Aliases
fn mi {|@a| micro $@a}

# Abbreviations
set edit:abbr['||'] = '| less'
