class Colors:
    reset = '\033[0m'
    bold = '\033[01m'
    disable = '\033[02m'
    underline = '\033[04m'
    reverse = '\033[07m'
    strikethrough = '\033[09m'
    invisible = '\033[08m'

    fg_black = '\033[30m'
    fg_red = '\033[31m'
    fg_green = '\033[32m'
    fg_orange = '\033[33m'
    fg_blue = '\033[34m'
    fg_purple = '\033[35m'
    fg_cyan = '\033[36m'
    fg_lightgrey = '\033[37m'
    fg_darkgrey = '\033[90m'
    fg_lightred = '\033[91m'
    fg_lightgreen = '\033[92m'
    fg_yellow = '\033[93m'
    fg_lightblue = '\033[94m'
    fg_pink = '\033[95m'
    fg_lightcyan = '\033[96m'

    bg_black = '\033[40m'
    bg_red = '\033[41m'
    bg_green = '\033[42m'
    bg_orange = '\033[43m'
    bg_blue = '\033[44m'
    bg_purple = '\033[45m'
    bg_cyan = '\033[46m'
    bg_lightgrey = '\033[47m'


# ASCII ART
ASCII_ART = """
{}--------------------------------------------------
       __      __  _____ __
  ____/ /___  / /_/ __(_) /__  _____
 / __  / __ \/ __/ /_/ / / _ \/ ___/
/ /_/ / /_/ / /_/ __/ / /  __(__  )
\__,_/\____/\__/_/ /_/_/\___/____/
Author: Ha Junsoo
Repository: https://github.com/kuc2477/dotfiles
Languages: Python, Haskell
Dependencies: cURL, git
--------------------------------------------------{}
""".format(Colors.bold, Colors.reset)

