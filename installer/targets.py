import os
import os.path
from . import commands as C
from . import utils as U
from .target import target
from .constants.urls import (
    SEOUL256_GNOME_URL,
    SEOUL256_ITERM_URL,
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
            'bash/autocompletions/docker-completion.bash',
            '~/.docker-completion.bash'
        ),
        C.link(
            'bash/autocompletions/docker-compose-completion.bash',
            '~/.docker-compose-completion.bash'
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


@target(['_submodules', '_font'])
def themes():
    # seoul256
    if not U.is_osx():
        install_seoul256_path = '~/.config/seoul256-gnome-terminal'
        install_seoul256 = (
            'git clone {url} {path} && '
            '. {path}/seoul256-dark.sh'
        ).format(url=SEOUL256_GNOME_URL, path=install_seoul256_path) \
            if not U.exists(install_seoul256_path) else None
    else:
        install_seoul256_path = '~/.config/seoul256-iTerm'
        install_seoul256 = (
            'git clone {url} {path} && '
            '. {path}/seoul256-dark.sh'
        ).format(url=SEOUL256_ITERM_URL, path=install_seoul256_path) \
            if not U.exists(install_seoul256_path) else None

    return install_seoul256


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
def python():
    if U.is_osx():
        install_pyenv_system_dependencies = None
        install_pyenv = 'brew update && brew install pyenv pyenv-virtualenv'
    else:
        install_pyenv_system_dependencies = C.install_system_packages(
            'make', 'libssl-dev', 'zlib1g-dev',
            'libbz2-dev', 'libreadline-dev', 'libsqlite3-dev', 'wget',
            'curl', 'llvm', 'libncurses5-dev'
        )
        install_pyenv = 'curl -L {} | bash'.format(PYENV_URL)

    return [
        C.if_no_command('pyenv', install_pyenv_system_dependencies),
        C.if_no_command('pyenv', install_pyenv),
        C.link('python/pypirc', '~/.pypirc'),
        C.link('python/pythonrc.py', '~/.pythonrc.py'),
    ]


@target
def javascript():
    return [
        C.if_no_command('nvm', 'curl -o- {} | bash'.format(NVM_URL)),
        '. ~/.nvm/nvm.sh && nvm install node',
        '. ~/.nvm/nvm.sh && nvm use node',
        C.link('javascript/tern-project', '~/.tern-project'),
    ]


@target
def haskell():
    return [
        C.if_no_command('stack', 'curl -sSL {} | sh'.format(STACK_URL)),
        'stack setup',
    ]


# ===============
# Utility Targets
# ===============

@target(['javascript'])
def utils():
    # system dependencies
    install_system_dependencies = C.install_system_packages(
        'libwebp-dev',
        'libgraphicsmagick++-dev'
    )

    # bins
    install_scripts = C.link('bin', '~/bin')

    # gogh
    install_gogh_dependencies = C.install_system_packages('dconf-cli')
    install_gogh = (
        'wget -O ~/bin/gogh https://git.io/vQgMr && '
        'chmod +x ~/bin/gogh'
    ) if not U.is_osx() else None

    # pgweb
    install_pgweb = 'brew cask install pgweb' if U.is_osx() else None

    # fzf
    install_fzf = (
        'git clone --depth 1 {} ~/.fzf && ~/.fzf/install --all'
        .format(FZF_URL) if not os.path.exists(os.path.expanduser('~/.fzf'))
        else None
    )

    # database related utils (often requires sudo authority)
    install_db_utils = (
        'sudo pip install pgcli'
    )

    commands = [
        install_scripts,
        install_gogh_dependencies,
        install_gogh,
        install_system_dependencies,
        install_pgweb,
        install_fzf,
        install_db_utils,
        'pip install saws haxor-news http-prompt khal',
        C.in_nvm('npm install -g git-standup tiny-care-terminal'),
        C.install_system_packages(
            'cowsay', 'fortune', 'toilet', 'autojump', 'task', 'pv', 'jq',
            'jid', 'httpie', 'ag', 'ranger', 'tig', 'irssi',
        ),
    ]

    return (
        commands if U.is_osx() else
        commands + [C.install_system_packages(
            'xdg-utils', 'gnome-tweak-tool', 'geary',
        )]
    )


# ==================
# Dependency Targets
# ==================

@target(['_submodules'])
def _font():
    return 'fonts/install.sh'


@target
def _submodules():
    return 'git submodule update --init'


@target(['python', '_font'])
def _vim_deps():
    return [
        C.install_system_packages('bashdb', 'cmake', 'ctags'),
        'pip install neovim',
        'pip3 install neovim'
    ]
