#!/usr/bin/env fish
source install-scripts/library/print-utils.fish

mkdir -p ~/.gnupg
if not test -f ~/.gnupg/gpg.conf
    print_info "Creating ~/.gnupg/gpg.conf with strong defaults"

    echo "use-agent
personal-digest-preferences SHA512
cert-digest-algo SHA512
default-preference-list SHA512 SHA384 SHA256 AES256 AES192 AES CAST5 ZLIB BZIP2 ZIP Uncompressed" > ~/.gnupg/gpg.conf
    chmod 600 ~/.gnupg/gpg.conf

    print_success "Done"
end

print_info "Restarting gpg-agent..."
gpgconf --kill gpg-agent
gpgconf --launch gpg-agent

set existing_keys (gpg --list-keys --with-colons 2> /dev/null | grep '^fpr' | cut -d: -f10)
if test (count $existing_keys) -eq 0
    print_info "No GPG keys found. Starting key generation..."
    gpg --full-generate-key
    set existing_keys (gpg --list-keys --with-colons 2> /dev/null | grep '^fpr' | cut -d: -f10)
end

print_info "Existing GPG keys:"
for fpr in $existing_keys
    set email (gpg --list-keys --with-colons $fpr | awk -F: -v fpr=$fpr 'BEGIN {found=0} /^fpr:/ {found=($10==fpr)} /^uid:/ && found { print $10; exit }' | grep -oE '<.*>' | tr -d '<>')
    print_text " - $fpr ($email)"
end

read -l -p "Enter the GPG key fingerprint to use: " GPG_KEY_FINGERPRINT

set key_exists (gpg --list-keys $GPG_KEY_FINGERPRINT > /dev/null 2>&1; echo $status)
if test "$key_exists" -ne 0
    echo "[x] GPG key not found. Aborting."
    exit 1
end

print_success "Done"
