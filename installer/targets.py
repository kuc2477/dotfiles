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
    HTOP_URL,
    PLUG_URL,
)


# ==============
# TARGETS (MAIN)
# ==============

@target(['_submodules', '_font'])
def shell():
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

    # seoul256
    if U.is_osx():
        install_seoul256_path = '~/.config/seoul256-gnome-terminal'
        install_seoul256 = (
            'git clone {url} {path}'
            '. {path}/seoul256-dark.sh'
        ).format(url=SEOUL256_GNOME_URL, path=install_seoul256_path) \
            if U.exists(install_seoul256_path) else None
    else:
        install_seoul256_path = '~/.config/seoul256-iTerm'
        install_seoul256 = (
            'git clone {url} {path}'
        ).format(url=SEOUL256_ITERM_URL, path=install_seoul256_path) \
            if U.exists(install_seoul256_path) else None

    # gogh
    install_gogh = '{} && {}'.format(
        C.install_system_packages('dconf-cli'),
        ('sudo wget -O /usr/local/bin/gogh https://git.io/vQgMr && '
         'sudo chmod +x /usr/local/bin/gogh')
    ) if not U.is_osx() else None

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
        # seoul256
        install_seoul256,
        # gogh
        install_gogh,
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
        C.link('bash/bashrc', '~/{}'.format(U.system_specific_name(
            'bashrc', U.current_system_name()
        )))
    ]


@target(['_vim_deps'])
def vim():
    if U.is_osx():
        prepare_vim_registry = ['brew tap neovim/neovim']
    else:
        prepare_vim_registry = [
            'sudo add-apt-repository ppa:neovim-ppa/stable --yes',
            'sudo apt-get update'
        ]

    return prepare_vim_registry + [
        C.install_system_packages('neovim'),
        'curl -fLo ~/.vim/autoload/plug.vim --create-dirs {}'.format(PLUG_URL),
        'mkdir -p ~/.config/nvim',
        C.link('vim/init.vim', '~/.config/nvim/init.vim'),
        C.link('vim/vimrc.vim', '~/.vimrc'),
        C.link('vim/snippets', '~/.snippets'),
        'nvim +PlugInstall +VimProcInstall +qall',
    ]


@target(['javascript', 'tmux'])
def utils():
    # scripts
    scripts = [
        'bin/rmswp',
        'bin/tpd',
        'bin/rmpyc'
    ]
    install_scripts = [C.link(s, '/usr/local/bin', sudo=True) for s in scripts]

    # system dependencies
    install_system_dependencies = C.install_system_packages(
        'libwebp-dev',
        'libgraphicsmagick++-dev'
    )

    # timg
    install_timg = C.if_no_command('timg', (
        'git clone https://github.com/hzeller/timg.git &&'
        'cd timg/src &&'
        'make &&'
        'sudo make install &&'
        'cd .. && '
        'cd .. && '
        'rm -rf ./timg'
    ))

    # pgweb
    if U.is_osx():
        install_pgweb = 'brew cask install pgweb'
    else:
        install_pgweb = C.link('bin/pgweb', '/usr/local/bin', sudo=True)

    # fzf
    install_fzf = (
        'git clone --depth 1 {} ~/.fzf && ~/.fzf/install --all'
        .format(FZF_URL) if not os.path.exists(os.path.expanduser('~/.fzf'))
        else None
    )

    # htop 2.02
    install_htop = ((
        'sudo apt install libncursesw5-dev && '
        'wget {HTOP_URL} && '
        'tar xzf htop-2.0.2.tar.gz && '
        'rm htop-2.0.2.tar.gz && '
        'cd htop-2.0.2 && '
        './configure && make && sudo make install && '
        'cd .. && '
        'rm -rf htop-2.0.2'
    ).format(HTOP_URL=HTOP_URL))

    commands = install_scripts + [
        install_system_dependencies,
        install_timg,
        install_pgweb,
        install_fzf,
        install_htop,
        'sudo pip install autoenv pgcli saws haxor-news http-prompt',
        'sudo pip3 install khal',
        C.in_nvm('npm install -g git-standup tiny-care-terminal'),
        C.install_system_packages(
            'cowsay', 'fortune', 'toilet', 'autojump', 'task', 'pv', 'jq',
            'jid', 'httpie', 'ag', 'ranger', 'tig', 'irssi'
        ),
    ]

    return (
        commands if U.is_osx() else
        commands + [C.install_system_packages(
            'xdg-utils', 'gnome-tweak-tool', 'geary',
        )]
    )


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
        C.link('tmux/tmux', '~/.tmux'),
        C.link('tmux/tmux.conf', '~/.tmux.conf'),
        C.link('tmux/tmux-powerline', '~/.tmux-powerline'),
        C.link('tmux/tmux-powerlinerc', '~/.tmux-powerlinerc'),
    ]


@target
def python():
    if U.is_osx():
        install_pyenv = 'brew update && brew install pyenv pyenv-virtualenv'
    else:
        install_pyenv = '{} && (curl -L {} | bash)'.format(
            C.install_system_packages(
                'make', 'build_essential', 'libssl-dev', 'zlib1g-dev',
                'libbz2-dev', 'libreadline-dev', 'libsqlite3-dev', 'wget',
                'curl', 'llvm', 'libncurses5-dev'
            ), PYENV_URL
        )

    return [
        C.if_no_command('pyenv', install_pyenv),
        C.link('python/pypirc', '~/.pypirc'),
        C.link('python/pythonrc.py', '~/.pythonrc.py'),
        C.link('python/pdbrc.py', '~/.pdbrc.py'),
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


# ======================
# TARGETS (DEPENDENCIES)
# ======================

@target(['_submodules'])
def _font():
    return 'fonts/install.sh'


@target
def _submodules():
    return 'git submodule update --init'


@target
def _powerline_status():
    return 'pip install powerline-status powerline-gitstatus'


@target(['python', '_font'])
def _vim_deps():
    return [
        C.install_system_packages('bashdb', 'cmake', 'ctags'),
        'pip install neovim',
        'pip3 install neovim'
    ]
