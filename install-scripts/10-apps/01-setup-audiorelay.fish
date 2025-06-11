#!/usr/bin/env fish
source install-scripts/library/print-utils.fish

print_info "Configuring audio relay"

if ! type -q ufw
    print_error "UFW not installed, fix this script to use your current firewall."
    return
end

if ! string match -q "Status: active" (sudo ufw status 2>/dev/null | head -n 1)
    print_warn "UFW is not active."
    return
else
    set rules (sudo ufw status 2>/dev/null | string match '*59100*')

    if test -z "$rules"
        print_info "Setting firewall rules so the app can connect"

        sudo ufw allow 59100:59103/tcp 2>/dev/null
        sudo ufw allow 59100:59103/udp 2>/dev/null
        sudo ufw reload 2>/dev/null
    end
end

set prefs_path ~/.java/.userPrefs/com/azefsw/audioconnect/prefs.xml

if not test -f $prefs_path
    print_warn "prefs.xml not found. Make sure AudioRelay has been launched at least once."
    return
end

print_info "Apply default settings"

sed -i 's|<entry key="device_capture_id" value="[^"]*"|<entry key="device_capture_id" value="AudioRelay-Virtual-Speaker"|' $prefs_path
sed -i 's|<entry key="device_render_id" value="[^"]*"|<entry key="device_render_id" value="AudioRelay-Virtual-Mic"|' $prefs_path
sed -i 's|<entry key="dark_mode" value="[^"]*"|<entry key="dark_mode" value="true"|' $prefs_path

print_success Done
