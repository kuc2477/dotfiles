from .registries import OPTION_REGISTRY
from .constants.system import SYSTEM_SPECIFIC_INSTALLER
from .utils import (
    current_system_name,
    system_specific_name,
    log_skipping_commands,
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

    if not OPTION_REGISTRY['sudo']:
        log_skipping_commands(system_specific_package_names)
        return

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

    if not OPTION_REGISTRY['sudo'] and sudo:
        log_skipping_commands([c])
        return

    return c
