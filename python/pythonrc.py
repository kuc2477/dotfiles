def _initialize_python_shell():
    try:
        from jedi.utils import setup_readline
        setup_readline()
    except ImportError:
        import readline
        readline.parse_and_bind("tab: complete")
    finally:
        import os.path
        history_file = os.path.join(os.environ['HOME'], '.python_history')
        readline.set_history_length(1000)
        readline.read_history_file(history_file)


_initialize_python_shell()
del _initialize_python_shell
