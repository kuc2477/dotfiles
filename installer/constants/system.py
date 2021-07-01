# SHELL
SHELL = '/bin/bash'

# SYSTEM SPECIFIC CONFIGURATIONS
SYSTEM_SPECIFIC_INSTALLER = {
    'osx': 'brew install',
    'debian': 'sudo apt-get install -y'
}
SYSTEM_SPECIFIC_NAMES = {
    'ag': {
        'osx': 'the_silver_searcher',
        'debian': 'silversearcher-ag'
    },
    'libevent': {
        'osx': 'libevent',
        'debian': 'libevent-dev'
    },
    'ctags': {
        'osx': 'ctags',
        'debian': 'exuberant-ctags'
    },
    'bashrc': {
        'osx': '.profile',
        'debian': '.bashrc'
    },
    'neovim': {
        'osx': 'neovim/neovim/neovim',
        'debian': 'neovim'
    },
    'python-pip': {'osx': None},
    'python3-pip': {'osx': None},
    'curl': {'osx': None},
    'jid': {'debian': None},
}
