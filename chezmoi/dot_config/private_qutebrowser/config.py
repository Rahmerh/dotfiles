config.load_autoconfig()

## Page(s) to open at the start.
c.url.start_pages = ['http://192.168.178.81:2021/']

# Website shortcuts
config.bind('YO', 'open -t https://www.youtube.com')

# Watch youtube
config.bind('<Ctrl-Shift-p>', 'hint links spawn --detach mpv --force-window yes {hint-url}')

# Appearance
config.set("colors.webpage.darkmode.enabled", True)
config.set ("window.hide_decoration", True)
