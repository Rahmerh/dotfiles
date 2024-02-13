#!/usr/bin/env fish
source $(dirname "$0")/library/print-utils.fish

# Disable screen sleep
xset -dpms
xset s off

print_info "Enabling and starting systemd services"

TIMER_ISACTIVE=$(sudo systemctl is-active system-backup.timer)
SERVICE_ISACTIVE=$(sudo systemctl is-active system-backup.service)

print_info "Systemctl daemon-reload"
sudo systemctl daemon-reload

if [ "$TIMER_ISACTIVE" != "active" ]; then
    print_info "Starting system backup systemd timer"
    sudo systemctl enable --now system-backup.timer
fi

if [ "$SERVICE_ISACTIVE" != "active" ]; then
    print_info "Starting system backup systemd service"
    sudo systemctl enable --now system-backup.service
fi

print_success "Done"
