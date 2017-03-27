def _initialize_python_shell():
    try:
        from jedi.utils import setup_readline
        setup_readline()
    except ImportError:
        import readline, rlcompleter
        readline.parse_and_bind("tab: complete")


_initialize_python_shell()
del _initialize_python_shell
