import os
from urllib.request import urlopen

config.load_autoconfig()

# Search engine
c.url.searchengines = {
    'DEFAULT':  'https://google.com/search?hl=en&q={}',
    '!gh':      'https://github.com/search?o=desc&q={}&s=stars',
    '!gist':    'https://gist.github.com/search?q={}',
    '!gi':      'https://www.google.com/search?tbm=isch&q={}&tbs=imgo:1',
    '!m':       'https://www.google.com/maps/search/{}',
    '!r':       'https://www.reddit.com/search?q={}',
    '!yt':      'https://www.youtube.com/results?search_query={}'
}

## Page(s) to open at the start.
c.url.start_pages = ['http://192.168.178.81:2021/']

# Watch youtube
config.bind('<Ctrl-Shift-p>', 'hint links spawn --detach mpv --force-window yes {hint-url}')

# Appearance
config.set("window.hide_decoration", True)

if not os.path.exists(config.configdir / "theme.py"):
    theme = "https://raw.githubusercontent.com/catppuccin/qutebrowser/main/setup.py"
    with urlopen(theme) as themehtml:
        with open(config.configdir / "theme.py", "a") as file:
            file.writelines(themehtml.read().decode("utf-8"))

if os.path.exists(config.configdir / "theme.py"):
    import theme
    theme.setup(c, 'mocha', True)
