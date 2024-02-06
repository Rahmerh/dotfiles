config.load_autoconfig()

## Page(s) to open at the start.
c.url.start_pages = ['http://192.168.178.81:2021/']

# Watch youtube
config.bind('<Ctrl-Shift-p>', 'hint links spawn --detach mpv --force-window yes {hint-url}')

# Appearance
config.set ("window.hide_decoration", True)

c.colors.webpage.darkmode.algorithm = 'lightness-cielab'
c.colors.webpage.darkmode.enabled = True
c.colors.webpage.darkmode.policy.images = 'never'
