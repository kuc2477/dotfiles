import os
import os.path

from . import commands as C
from . import utils as U
from .constants.urls import (
    FZF_URL,
    NVM_URL,
    PLUG_URL,
    STACK_URL,
    JUPYTER_VIM_BINDING_URL,
    AUTOJUMP_URL,
    AG_URL,
)
from .target import target


LOCAL_PREFIX = '$HOME/.local/'

COLOR_NONE = '\033[0m'
COLOR_RED = '\033[0;31m'
COLOR_GREEN = '\033[0;32m'
COLOR_YELLOW = '\033[0;33m'
COLOR_WHITE = '\033[1;37m'


@target
def conda():
    pass


@target
def nvim():
    return 'bash installer/linux_locals.sh install_neovim'


@target
def stack():
    return [
        C.if_no_command('stack', 'curl -sSL {} | bash'.format(STACK_URL)),
        'stack setup',
    ]


@target
def fd():
    return 'bash installer/linux_locals.sh install_fd'


@target
def tmux():
    return 'bash installer/linux_locals.sh install_tmux'


@target(['_submodules', '_font'])
def powerline():
    # powerline
    get_powerline_root_dir = (lambda: U.stdout(
        'pip show powerline-status | '
        'grep -i location | grep -Eo /.*$',
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
            '~/.config/powerline/config.json', rel=False,
        ),
        C.link(
            '{}/colorscheme.json'.format(powerline_config_dir),
            '~/.config/powerline/colorschemes/default.json', rel=False,
        ),
        C.link(
            '{}/theme.json'.format(powerline_config_dir),
            '~/.config/powerline/themes/shell/default.json', rel=False,
        ),
    ]


@target
def jupyter():
    install_jupyter_packages = 'pip install ' + ' '.join([
        'jupyter',
        'jupyterthemes',
        'jupyter_contrib_nbextensions',
        'jupyter_nbextensions_configurator',
    ])
    install_jupyter_nbexts = [
        'jt -t gruvboxd',
        'jupyter contrib nbextension install --user',
        'jupyter nbextensions_configurator enable --use',
        'mkdir -p {}/nbextensions'.format(U.stdout('jupyter --data-dir')),
        'cd {}/nbextensions && git clone {} && chmod -R go-w vim_binding'
        .format(U.stdout('jupyter --data-dir'), JUPYTER_VIM_BINDING_URL),
    ]
    return [
        install_jupyter_packages,
        *install_jupyter_nbexts
    ]


@target
def completions():
    return [
        C.link(
            'bash/autocompletions/git-completion.bash',
            '~/.git-completion.bash',
        ),
        C.link(
            'bash/autocompletions/tmux-completion.bash',
            '~/.tmux-completion.bash',
        ),
    ]


@target
def configs():
    return [
        # tmux
        C.link('tmux/tmux', '~/.tmux'),
        C.link('tmux/tmux.conf', '~/.tmux.conf'),
        C.link('tmux/tmux-powerline', '~/.tmux-powerline'),
        C.link('tmux/tmux-powerlinerc', '~/.tmux-powerlinerc'),
        # bash configuration
        C.link('bash/bashrc', '~/.bashrc'),
        C.link('bash/bash_profile', '~/.bash_profile'),
        # direnv configuration
        C.link('bash/direnvrc', '~/.direnvrc'),
        # vim
        'curl -fLo ~/.vim/autoload/plug.vim --create-dirs {}'.format(PLUG_URL),
        'mkdir -p ~/.config/nvim',
        C.link('vim/init.vim', '~/.config/nvim/init.vim'),
        C.link('vim/coc-settings.json', '~/.config/nvim/coc-settings.json'),
        C.link('vim/vimrc.vim', '~/.vimrc'),
    ]


@target(['_vim_deps'])
def vim_plugins():

    coc_plugs = ' '.join([
        # autocompletions
        'coc-jedi',
        'coc-sh',
        'coc-json',
        'coc-yaml',
        'coc-html',
        # lint
        'coc-diagnostic',
    ])
    return [
        'curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim',
        'vi +PlugInstall +VimProcInstall +qall',
        # f'vi \'+CocInstall {coc_plugs}\'',
    ]


@target
def bins():
    return C.link('bin', '~/bin')


@target
def nvm():
    return f'wget -qO- {NVM_URL} | bash'


@target
def fzf():
    return (
        f'git clone --depth 1 {FZF_URL} ~/.fzf && ~/.fzf/install --all'
        if not os.path.exists(os.path.expanduser('~/.fzf')) else None
    )


@target
def miscs():
    autojump = (
        f'git clone {AUTOJUMP_URL} && cd autojump && ./install.py && '
        'cd .. && rm -rf autojump'
    )
    return [
        autojump,
        C.install_system_packages(
            'cowsay', 'fortune', 'toilet',
            'ag', 'ranger', 'tig', 'ctags',
        )
    ]


@target
def _submodules():
    return 'git submodule update --init'


@target(['_submodules'])
def _font():
    return 'fonts/install.sh'


@target(['_font'])
def _vim_deps():
    packages = ' '.join([
        'neovim',
        'jedi',
        'flake8',
        'yamllint',
    ])
    return f'pip install -U {packages}'
