import os
import os.path
from . import commands as C
from . import utils as U
from .target import target
from .constants.urls import (
    NVM_URL,
    STACK_URL,
    PYENV_URL,
    FZF_URL,
    PLUG_URL,
    JUPYTER_VIM_BINDING_URL,
)


# =========================
# Shell Environment Targets
# =========================

@target
def bashrc():
    return [
        # autocompletions
        C.install_system_packages('bash-completion'),
        C.link(
            'bash/autocompletions/git-completion.bash',
            '~/.git-completion.bash',
        ),
        C.link(
            'bash/autocompletions/tmux-completion.bash',
            '~/.tmux-completion.bash'
        ),
        # bash configuration
        C.link('bash/bashrc', '~/.bashrc'),
        C.link('bash/bash_profile', '~/.bash_profile'),
        # direnv configuration
        C.link('bash/direnvrc', '~/.direnvrc')
    ]


# ================
# Powerline Target
# ================

@target(['_submodules', '_font'])
def powerline():
    # powerline
    get_powerline_root_dir = (lambda: U.stdout(
        'pip show powerline-status | '
        'grep -i location | grep -Eo /.*$'
    ))
    get_powerline_bash_binding_path = (
        lambda: '{}/powerline/bindings/bash/powerline.sh'.format(
            get_powerline_root_dir()
        )
    )
    powerline_config_dir = '{}/bash/powerline-configs'.format(U.stdout('pwd'))

    return [
        # powerline
        'pip install powerline-status powerline-gitstatus',
        'mkdir -p ~/.config/powerline/colorschemes',
        'mkdir -p ~/.config/powerline/themes/shell',
        (lambda: C.link(get_powerline_bash_binding_path(),
                        '~/.powerline', rel=False)),
        C.link(
            '{}/config.json'.format(powerline_config_dir),
            '~/.config/powerline/config.json', rel=False
        ),
        C.link(
            '{}/colorscheme.json'.format(powerline_config_dir),
            '~/.config/powerline/colorschemes/default.json', rel=False
        ),
        C.link(
            '{}/theme.json'.format(powerline_config_dir),
            '~/.config/powerline/themes/shell/default.json', rel=False
        ),
    ]


# ==========================
# Jupyter Environment Target
# ==========================

@target
def jupyter():
    return 'pip install ' + ' '.join([
        'jupyter',
        'jupyterthemes',
        'jupyter_contrib_nbextensions',
        'jupyter_nbextensions_configurator',
    ])


@target
def jupyter_configs():
    jupyter_data_dir = U.stdout('jupyter --data-dir')
    return [
        'jt -t gruvboxd',
        'jupyter contrib nbextension install --user',
        'jupyter nbextensions_configurator enable --use',
        'mkdir -p {}/nbextensions'.format(jupyter_data_dir),
        'cd {}/nbextensions && git clone {} && chmod -R go-w vim_binding'
        .format(jupyter_data_dir, JUPYTER_VIM_BINDING_URL)
    ]


# ====================
# Vim Specific Targets
# ====================

@target(['_vim_deps'])
def vim():
    if U.is_osx():
        prepare_vim_registry = ['brew tap neovim/neovim']
    else:
        prepare_vim_registry = [
            'sudo add-apt-repository ppa:neovim-ppa/stable --yes',
            'sudo apt-get update'
        ]
    return prepare_vim_registry + [C.install_system_packages('neovim')]


@target
def vimrc():
    return [
        'curl -fLo ~/.vim/autoload/plug.vim --create-dirs {}'.format(PLUG_URL),
        'mkdir -p ~/.config/nvim',
        C.link('vim/init.vim', '~/.config/nvim/init.vim'),
        C.link('vim/vimrc.vim', '~/.vimrc'),
        C.link('vim/snippets', '~/.snippets'),
        'vi +PlugInstall +VimProcInstall +qall',
    ]


# =====================
# Tmux Specific Targets
# =====================

@target(['_submodules', '_font'])
def tmux():
    if U.is_osx():
        deps = [
            'pkg-config', 'libevent', 'automake',
            'reattach-to-user-namespace'
        ]
    else:
        deps = [
            'pkg-config', 'libevent', 'automake',
            'libncurses-dev'
        ]

    compile_tmux = (
        'cd tmux/tmux-src && ./autogen.sh && ./configure && '
        'make && sudo make install'
    )

    return [
        C.install_system_packages(*deps),
        C.if_no_command('tmux', compile_tmux),
    ]


@target(['_submodules', '_font'])
def tmuxrc():
    return [
        C.link('tmux/tmux', '~/.tmux'),
        C.link('tmux/tmux.conf', '~/.tmux.conf'),
        C.link('tmux/tmux-powerline', '~/.tmux-powerline'),
        C.link('tmux/tmux-powerlinerc', '~/.tmux-powerlinerc'),
    ]


# =====================================
# Language Specific Environment Targets
# =====================================

@target
def conda():
    return [
    ]


@target
def stack():
    return [
        C.if_no_command('stack', 'curl -sSL {} | sh'.format(STACK_URL)),
        'stack setup',
    ]


# ===============
# Utility Targets
# ===============

@target(['javascript'])
def utils():
    # bins
    install_scripts = C.link('bin', '~/bin')

    # fzf
    install_fzf = (
        'git clone --depth 1 {} ~/.fzf && ~/.fzf/install --all'
        .format(FZF_URL) if not os.path.exists(os.path.expanduser('~/.fzf'))
        else None
    )

    return [
        install_scripts,
        install_fzf,
        'pip install saws haxor-news http-prompt khal',
        C.install_system_packages(
            'cowsay', 'fortune', 'toilet', 'autojump', 'task', 'pv', 'jq',
            'jid', 'httpie', 'ag', 'ranger', 'tig', 'irssi',
        ),
    ]


# ==================
# Dependency Targets
# ==================

@target
def _submodules():
    return 'git submodule update --init'

@target(['_submodules'])
def _font():
    return 'fonts/install.sh'


@target(['_font'])
def _vim_deps():
    return [
        'pip install neovim',
        'pip3 install neovim'
    ]
