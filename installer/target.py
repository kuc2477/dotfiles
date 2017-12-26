import functools
import copy
from . import utils
from .registries import TARGET_REGISTRY


def target(*args):
    assert (
        (len(args) == 1 and isinstance(args[0], list)) or
        (len(args) == 1 and callable(args[0]))
    )

    # determine dependencies from given arguements
    dependencies = [] if callable(args[0]) else args[0]

    # wrapped function runs dependencies before the function itself.
    def create_wrapped(f):
        @functools.wraps(f)
        def wrapped(breadcrumb=None):
            # dependency breadcrumb
            name = f.__name__
            breadcrumb = copy.deepcopy(breadcrumb) or []
            breadcrumb += [name]

            # print installation target information
            with utils.log_command_with_dependencies(
                    f, dependencies, breadcrumb
            ):
                for dep in dependencies:
                    # run dependencies
                    install_target = TARGET_REGISTRY[dep]
                    install_command = install_target.command()
                    has_dependencies = install_target.dependencies
                    not_ran = not utils.ran(dep)
                    not_none_or_empty = not utils.none_or_empty(
                        install_command
                    )
                    if not_ran and (not_none_or_empty or has_dependencies):
                        install_target(breadcrumb)
                else:
                    # run the command itself and mark after execution
                    install_command = f()
                    not_ran = not utils.ran(name)
                    not_none_or_empty = not utils.none_or_empty(
                        install_command
                    )
                    if not_ran and not_none_or_empty:
                        with utils.log_command(f, breadcrumb):
                            utils.run(install_command)
                            TARGET_REGISTRY[name].ran = True

        wrapped.command = f
        wrapped.dependencies = dependencies
        return wrapped

    # return decorator in case of target with dependencies
    if dependencies:
        def decorator(f):
            wrapped = create_wrapped(f)
            TARGET_REGISTRY[f.__name__] = wrapped
            TARGET_REGISTRY[f.__name__].ran = False
            return wrapped
        return decorator
    # return wrapped function in case of zero dependencies
    else:
        wrapped = create_wrapped(args[0])
        TARGET_REGISTRY[args[0].__name__] = wrapped
        TARGET_REGISTRY[args[0].__name__].ran = False
        return wrapped
