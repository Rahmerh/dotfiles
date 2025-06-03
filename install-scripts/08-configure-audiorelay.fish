#!/usr/bin/env fish
source install-scripts/library/print-utils.fish

print_info "Configuring audio relay"

if ! type -q ufw
    print_error "UFW not installed, fix this script to use your current firewall."
    return
end

if ! string match -q "Status: active" (sudo ufw status 2>/dev/null | head -n 1)
    echo "UFW is not active."
    return
end

set rules (sudo ufw status 2>/dev/null | string match '*59100*')

if test -z "$rules"
    print_info "Setting firewall rules so the app can connect"

    sudo ufw allow 59100:59103/tcp 2>/dev/null
    sudo ufw allow 59100:59103/udp 2>/dev/null
    sudo ufw reload 2>/dev/null
end

set sink_exists (pactl list short sinks | grep -c audiorelay-out)

if test $sink_exists -eq 0
    print_info "Creating audio sink"
    pactl load-module module-null-sink sink_name=audiorelay-out sink_properties=device.description=AudioRelay-Virtual-Speaker
end

print_success "Done"
