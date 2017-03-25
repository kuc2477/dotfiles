import atexit
import os
try:
    import readline
except:
    readline = None
import rlcompleter

def _init():
    history_file = os.path.join(os.environ['HOME'], '.python_history')
    try:
        readline.read_history_file(history_file)
    except IOError:
        pass
    readline.parse_and_bind("tab: complete")
    readline.set_history_length(1000)
    atexit.register(readline.write_history_file, history_file)


_init()
del _init
del atexit, os, readline, rlcompleter
