#!/usr/bin/env fish
source install-scripts/library/print-utils.fish

print_info "Creating wallpaper"

set bg "#2C2C2C"
set pink "#E85A98"
set out ~/Pictures/wallpaper.png
set font "/usr/share/fonts/noto-cjk/NotoSansCJK-Regular.ttc"
set sigfont "/usr/share/fonts/TTF/DejaVuSansMono.ttf"
set tmp (mktemp -d)

# Create base canvas
magick -size 5120x1440 xc:"$bg" miff:"$tmp/canvas.miff"

# Bottom-right diagnostics (stacked with spacing)
magick -size 5120x1440 xc:none -fill '#555' -font "$font" -pointsize 20 \
    -gravity SouthEast -annotate +50+50 "/ ノード: 13-AZ | 暗号鍵: 有効\n|  Σ 転送速度: 7.2MB/s / 安定\n\n/ ノード: 13-AZ | サブノード接続: 4/4\n|  Σ 信号強度: -61dBm / 安定" \
    miff:"$tmp/diag.miff"

# Polygon bands
magick -size 5120x1440 xc:none -fill "$pink" -draw "polygon 0,0 200,0 500,1440 300,1440" miff:"$tmp/band1.miff"
magick -size 5120x1440 xc:none -fill "$pink" -draw "polygon 300,0 400,0 700,1440 600,1440" miff:"$tmp/band2.miff"
magick -size 5120x1440 xc:none -fill "$pink" -draw "polygon 500,0 600,0 900,1440 800,1440" miff:"$tmp/band3.miff"

# Compositing steps
magick "$tmp/canvas.miff" "$tmp/diag.miff" -compose Over -composite miff:"$tmp/step0.miff"
magick "$tmp/step0.miff" "$tmp/band1.miff" -compose Over -composite miff:"$tmp/step1.miff"
magick "$tmp/step1.miff" "$tmp/band2.miff" -compose Over -composite miff:"$tmp/step2.miff"
magick "$tmp/step2.miff" "$tmp/band3.miff" -compose Over -composite miff:"$tmp/step3.miff"

# Top-right diagnostic block
magick "$tmp/step3.miff" \
    -font "$font" -pointsize 42 -gravity NorthEast -fill white \
    -annotate +50+50 ":: シグマノード13-AZ / オンライン\n>>> コア温度：36.7°C ▊\n::: 信号強度：-67dBm / ノイズ：+11.4dB\n>>> セキュリティ：███ ███░░░ 低\n:: クロック同期：+0.03秒\n::: 不明なプロトコル活動 (02x13)\n>>> シャドウスレッド：3 実行中\n>>> SYSLOG[1059]：ポートϟ 5189-TCP 開放" \
    -font "$sigfont" -pointsize 14 -gravity SouthWest -fill "#444" \
    -annotate +20+20 "ayame.gen // 2025" \
    "$out"

pkill hyprpaper
hyprctl dispatch exec hyprpaper

print_success Done
