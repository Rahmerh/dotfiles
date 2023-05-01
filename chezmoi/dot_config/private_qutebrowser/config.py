config.load_autoconfig()

# Bitwarden binds
config.bind('www', 'spawn --userscript qute-bitwarden')
config.bind('wwp', 'spawn --userscript qute-bitwarden --password-only')
config.bind('wwu', 'spawn --userscript qute-bitwarden --username-only')

# Website shortcuts
config.bind('YO', 'open -t https://www.youtube.com')
