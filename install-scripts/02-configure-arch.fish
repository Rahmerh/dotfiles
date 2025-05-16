#!/usr/bin/env fish
source install-scripts/library/print-utils.fish

# Disable screen sleep
xset -dpms
xset s off

print_info "Enabling and starting systemd services"

set TIMER_ISACTIVE (sudo systemctl is-active system-backup.timer)
set SERVICE_ISACTIVE (sudo systemctl is-active system-backup.service)

print_info "Systemctl daemon-reload"
sudo systemctl daemon-reload

if [ "$TIMER_ISACTIVE" != "active" ]
    print_info "Starting system backup systemd timer"
    sudo systemctl enable --now system-backup.timer
end

if [ "$SERVICE_ISACTIVE" != "active" ]
    print_info "Starting system backup systemd service"
    sudo systemctl enable --now system-backup.service
end

print_success "Done"
