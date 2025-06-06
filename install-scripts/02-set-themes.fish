#!/usr/bin/env fish
source install-scripts/library/print-utils.fish

print_info "Setting kitty theme"

if ! test -d ~/dotfiles/home/.config/kitty/themes/kitty-themes
    git clone --depth 1 https://github.com/dexpota/kitty-themes.git ~/dotfiles/home/.config/kitty/themes/kitty-themes &> /dev/null
else
    cd ~/dotfiles/home/.config/kitty/themes/kitty-themes
    git pull &> /dev/null
end

cp ~/dotfiles/home/.config/kitty/themes/kitty-themes/themes/Chalk.conf ~/dotfiles/home/.config/kitty/themes/theme.conf

print_success "Done"

print_info "Setting sddm theme"

if ! test -d /tmp/sddm-theme 
    git clone git@github.com:stepanzubkov/where-is-my-sddm-theme.git /tmp/sddm-theme &> /dev/null
else
    cd /tmp/sddm-theme 
    git pull &> /dev/null
end

sudo /tmp/sddm-theme/install.sh current &> /dev/null

print_success "Done"

print_info "Setting librewolf theme"

if ! test -d /tmp/librewolf-theme 
    git clone git@github.com:cascadefox/cascade.git /tmp/librewolf-theme &> /dev/null
else
    cd /tmp/librewolf-theme/
    git pull &> /dev/null
end

cd ~/.librewolf/*.default-default

cp -r /tmp/librewolf-theme/chrome .

print_success "Done"

print_info "Creating wallpaper"

set bg "#2C2C2C"
set pink "#E85A98"
set out ~/Pictures/wallpaper.png
set font "/usr/share/fonts/noto-cjk/NotoSansCJK-Regular.ttc"
set sigfont "/usr/share/fonts/TTF/DejaVuSansMono.ttf"

# Create base canvas
magick -size 5120x1440 xc:"$bg" miff:canvas.miff

# Bottom-right diagnostics (stacked with spacing)
magick -size 5120x1440 xc:none -fill '#555' -font "$font" -pointsize 20 \
  -gravity SouthEast -annotate +50+50 "/ ノード: 13-AZ | 暗号鍵: 有効\n|  Σ 転送速度: 7.2MB/s / 安定\n\n/ ノード: 13-AZ | サブノード接続: 4/4\n|  Σ 信号強度: -61dBm / 安定" \
  miff:diag.miff

# Polygon bands
magick -size 5120x1440 xc:none -fill "$pink" -draw "polygon 0,0 200,0 500,1440 300,1440" miff:band1.miff
magick -size 5120x1440 xc:none -fill "$pink" -draw "polygon 300,0 400,0 700,1440 600,1440" miff:band2.miff
magick -size 5120x1440 xc:none -fill "$pink" -draw "polygon 500,0 600,0 900,1440 800,1440" miff:band3.miff

# Compositing steps
magick canvas.miff diag.miff -compose Over -composite miff:step0.miff
magick step0.miff band1.miff -compose Over -composite miff:step1.miff
magick step1.miff band2.miff -compose Over -composite miff:step2.miff
magick step2.miff band3.miff -compose Over -composite miff:step3.miff

# Top-right diagnostic block
magick step3.miff \
  -font "$font" -pointsize 42 -gravity NorthEast -fill white \
  -annotate +50+50 ":: シグマノード13-AZ / オンライン\n>>> コア温度：36.7°C ▊\n::: 信号強度：-67dBm / ノイズ：+11.4dB\n>>> セキュリティ：███ ███░░░ 低\n:: クロック同期：+0.03秒\n::: 不明なプロトコル活動 (02x13)\n>>> シャドウスレッド：3 実行中\n>>> SYSLOG[1059]：ポートϟ 5189-TCP 開放" \
  -font "$sigfont" -pointsize 14 -gravity SouthWest -fill "#444" \
  -annotate +20+20 "ayame.gen // 2025" \
  "$out"

# Cleanup
rm canvas.miff diag.miff band1.miff band2.miff band3.miff \
   step0.miff step1.miff step2.miff step3.miff

# Script tuned by Ayame: sharp edges, sharper attitude.
# Thank GPT for generating this mess.

pkill hyprpaper
hyprctl dispatch exec hyprpaper

print_success "Done"

print_info "Removing default task bar"

if ! test -e ~/dotfiles/config-backups/plasma-org.kde.plasma.desktop-appletsrc
    cp ~/.config/plasma-org.kde.plasma.desktop-appletsrc ~/dotfiles/config-backups/
end

sed -i '/\[Containments\]\[[0-9]*\]/,/^\[/ {/plugin=org.kde.panel/d}' ~/.config/plasma-org.kde.plasma.desktop-appletsrc
sed -i '/org.kde.plasma.panel/d' ~/.config/plasmashellrc

print_success "Done"
