import contextlib
import os
import os.path
from sys import platform
import subprocess
from .registries import TARGET_REGISTRY
from .constants.ascii import Colors
from .constants.system import SYSTEM_SPECIFIC_NAMES
# ================
# UTILITIES (CODE)
# ================

def header(string, margin_top=True, margin_bottom=False):
    margin_top = '\n' if margin_top else ''
    margin_bottom = '\n' if margin_bottom else ''
    divider = '=' * len(string)
    return (
        margin_top +
        divider + '\n' +
        string + '\n' +
        divider +
        margin_bottom
    )


def breadcrumb(stack, include_current=False):
    marker = '->'
    depth = len(stack)
    if include_current:
        return '[{}] '.format((marker.join(stack))) if depth > 0 else ''
    else:
        return '[{}] '.format(marker.join(stack[:depth-1])) \
            if depth > 1 else ''


def style(string, styles=None, stdout=True):
    # apply styles
    styles = styles or []
    styled = '{}{}'.format(string, Colors.reset)
    for s in styles:
        styled = getattr(Colors, s.lower()) + styled

    # print to stdout
    if stdout:
        print(styled)

    # return styled string
    return styled


def exists(path):
    return os.path.exists(os.path.expanduser(path))


@contextlib.contextmanager
def log_command_with_dependencies(f, dependencies, stack):
    name = f.__name__
    name_stripped = name.lstrip('_')
    dependencies_stripped = [n.lstrip('_') for n in dependencies]
    breadcrumb_stripped = [n.lstrip('_') for n in stack]
    is_root = len(stack) == 1

    # display installation information on start
    if dependencies and is_root:
        style(header('{}Installing {} with dependencies: {}'.format(
            breadcrumb(breadcrumb_stripped), name_stripped,
            dependencies_stripped
        ), margin_top=False), ['fg_cyan', 'bold'])

    yield


@contextlib.contextmanager
def log_command(f, stack):
    name_stripped = f.__name__.lstrip('_')
    breadcrumb_stripped = [n.lstrip('_') for n in stack]

    # styles
    start_styles = ['fg_yellow', 'bold']
    end_styles = ['bold']

    # display installation information on start
    style(header('{}Installing {}'.format(
        breadcrumb(breadcrumb_stripped), name_stripped
    )), start_styles)

    yield

    # display installation information on done
    style('\n# Installed {}!'.format(name_stripped), end_styles)


def log_skipping_commands(command_names, reason='no sudo authority'):
    for command_name in command_names:
        style('=> skipping command ({reason}): {command_name}'.format(
            reason=reason, command_name=command_name
        ), styles=['fg_yellow', 'bold'])


def current_system_name():
    return 'osx' if is_osx() else 'debian'


def is_osx():
    return platform == 'darwin'


def system_specific_name(name, system):
    try:
        return SYSTEM_SPECIFIC_NAMES[name][system]
    except KeyError:
        return name


def none_or_empty(command):
    is_none = command is None
    empty_string = isinstance(command, str) and len(command.strip()) == 0
    empty_iterable = (isinstance(command, (list, tuple)) and len(command) == 0)
    return is_none or empty_string or empty_iterable


def ran(target_name):
    return TARGET_REGISTRY[target_name].ran


def run(command):
    _run_maybe_thunk_command = (
        lambda c: os.system(c()) if callable(c) and c()
        else c and os.system(c)
    )
    if isinstance(command, (list, tuple)):
        for c in command:
            _run_maybe_thunk_command(c)
    else:
        _run_maybe_thunk_command(command)


def stdout(command):
    return subprocess.check_output(command, shell=True).strip()
