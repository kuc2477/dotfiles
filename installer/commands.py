from .constants.system import SYSTEM_SPECIFIC_INSTALLER
from .utils import (
    current_system_name,
    system_specific_name,
)


# ==========================
# UTILITIES (COMMAND STRING)
# ==========================

def in_nvm(command, version='node'):
    return '. ~/.nvm/nvm.sh && nvm use {} && ({})'.format(version, command)


def install_system_packages(package, *packages):
    system = current_system_name()
    installer = SYSTEM_SPECIFIC_INSTALLER[system]
    system_specific_package_names = [
        system_specific_name(name, system)
        for name in [package] + list(packages)
        if system_specific_name(name, system) is not None
    ]

    return '{} {}'.format(installer, ' '.join([
        n for n in system_specific_package_names
    ]))


def sudo_on_system(command, system):
    maybe_sudo = 'sudo ' if system == current_system_name() else ''
    return '{}{}'.format(maybe_sudo, command)


def if_no_command(name, command):
    return 'command -v {} >/dev/null || ({})'.format(name, command)


def link(path, to, rel=True, sudo=False):
    if rel:
        c = '{} ln -sf `pwd`/{} {}'.format('sudo' if sudo else '', path, to)
    else:
        c = '{} ln -sf {} {}'.format('sudo' if sudo else '', path, to)

    return 'if [[ ! -d {to} ]]; then {c}; fi'.format(to=to, c=c)
