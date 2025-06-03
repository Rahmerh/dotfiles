config.load_autoconfig(False)

# Keybinds
config.bind('<Ctrl-y>', 'spawn --userscript qute-pass')

# Theme settings
config.set("colors.webpage.darkmode.enabled", True)
config.set("colors.webpage.darkmode.policy.images", "smart")
config.set("colors.webpage.darkmode.policy.page", "smart")

config.source('themes/qute-city-lights/city-lights-theme.py')

# Misc settings
c.content.headers.user_agent = "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Safari/537.36"

