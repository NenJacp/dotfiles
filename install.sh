#!/bin/bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [ -z "$ZSH_VERSION" ]; then
    exec zsh "$0" "$@"
fi

echo "========================================="
echo "  Dotfiles Installation Script"
echo "========================================="

detect_os() {
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        case "$ID" in
            fedora|rhel|centos)
                echo "fedora"
                ;;
            arch|manjaro|endeavouros)
                echo "arch"
                ;;
            debian|ubuntu|linuxmint)
                echo "debian"
                ;;
            *)
                echo "unknown"
                ;;
        esac
    else
        echo "unknown"
    fi
}

OS=$(detect_os)
echo "Detected OS: $OS"

install_packages_fedora() {
    echo "Installing packages for Fedora..."

    setup_copr_fedora

    echo "Removing sway if present (to replace with swayfx)..."
    sudo dnf remove -y sway 2>/dev/null || true

    sudo dnf install -y --skip-broken --allowerasing \
        zsh \
        neovim \
        btop \
        rofi \
        kitty \
        grim \
        slurp \
        wl-clipboard \
        pamixer \
        brightnessctl \
        gammastep \
        playerctl \
        NetworkManager \
        NetworkManager-tui \
        dunst \
        libnotify \
        swayfx \
        swaylock \
        swayidle \
        waybar \
        mako \
        fontconfig

    install_nerd_fonts
    install_lazygit_fedora
    setup_node_fedora
}

setup_copr_fedora() {
    echo "Setting up COPR repos..."
    if ! sudo dnf copr list | grep -q "mochaa/swayfx"; then
        sudo dnf copr enable -y mochaa/swayfx
    fi
}

install_nerd_fonts() {
    echo "Installing Nerd Fonts..."
    if ! fc-list | grep -qi "jetbrains"; then
        mkdir -p /tmp/nerd-fonts
        curl -sL "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.0/JetBrainsMono.zip" -o /tmp/nerd-fonts/jetbrains.zip
        sudo unzip -o /tmp/nerd-fonts/jetbrains.zip -d /usr/share/fonts
        sudo fc-cache -f
        rm -rf /tmp/nerd-fonts
    fi
}

install_lazydocker_fedora() {
    echo "Installing lazydocker..."
    LAZYDOCKER_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazydocker/releases/latest" | python3 -c "import sys,json; print(json.load(sys.stdin)['tag_name'].replace('v',''))")
    curl -sL "https://github.com/jesseduffield/lazydocker/releases/download/v${LAZYDOCKER_VERSION}/lazydocker_${LAZYDOCKER_VERSION}_Linux_x86_64.tar.gz" -o /tmp/lazydocker.tar.gz
    sudo tar -xzf /tmp/lazydocker.tar.gz -C /usr/local/bin lazydocker
    rm /tmp/lazydocker.tar.gz
}

install_lazygit_fedora() {
    echo "Installing lazygit..."
    LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | python3 -c "import sys,json; print(json.load(sys.stdin)['tag_name'].replace('v',''))")
    curl -sL "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz" -o /tmp/lazygit.tar.gz
    sudo tar -xzf /tmp/lazygit.tar.gz -C /usr/local/bin lazygit
    rm /tmp/lazygit.tar.gz
}

setup_node_fedora() {
    echo "Setting up Node.js LTS..."
    if ! command -v node &> /dev/null || [[ "$(node -v)" != "v20"* && "$(node -v)" != "v22"* ]]; then
        curl -fsSL https://rpm.nodesource.com/setup_20.x | sudo bash -
        sudo dnf install -y nodejs
    fi
}

setup_docker_fedora() {
    echo "Setting up Docker..."
    if [ ! -f /etc/yum.repos.d/docker-ce.repo ]; then
        sudo dnf install -y dnf-plugins-core
        sudo dnf config-manager addrepo --from-repofile https://download.docker.com/linux/fedora/docker-ce.repo
    fi
    sudo dnf install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
    sudo systemctl enable --now docker
    sudo usermod -aG docker $USER
}

setup_docker() {
    case "$OS" in
        fedora)
            setup_docker_fedora
            ;;
        *)
            sudo systemctl enable --now docker 2>/dev/null || true
            sudo usermod -aG docker $USER 2>/dev/null || true
            ;;
    esac
}

install_packages_arch() {
    echo "Installing packages for Arch Linux..."

    sudo pacman -S --noconfirm \
        zsh \
        git \
        curl \
        wget \
        nodejs \
        npm \
        docker \
        btop \
        mako \
        waybar \
        sway \
        swaylock \
        swayidle \
        rofi \
        kitty \
        neovim \
        lazydocker \
        lazygit \
        fontconfig \
        wl-clipboard \
        grim \
        slurp \
        pamixer \
        brightnessctl \
        gammastep \
        mpd \
        playerctl \
        networkmanager \
        polkit-gnome \
        dunst \
        libnotify \
        pulseaudio \
        pipewire \
        pipewire-pulse
}

install_packages_debian() {
    echo "Installing packages for Debian/Ubuntu..."

    sudo apt update && sudo apt install -y \
        zsh \
        git \
        curl \
        wget \
        nodejs \
        npm \
        docker.io \
        docker-compose \
        btop \
        mako \
        waybar \
        sway \
        swaylock \
        rofi \
        kitty \
        neovim \
        lazygit \
        fontconfig \
        wl-clipboard \
        grim \
        slurp \
        pamixer \
        brightnessctl \
        gammastep \
        mpd \
        playerctl \
        network-manager \
        policykit-1-gnome \
        dunst \
        libnotify-bin \
        pulseaudio \
        pipewire \
        pipewire-pulseaudio
}

setup_node_lts() {
    echo "Setting up Node.js LTS..."
    if ! command -v node &> /dev/null || [[ "$(node -v)" != "v20"* && "$(node -v)" != "v22"* ]]; then
        curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
        sudo apt install -y nodejs 2>/dev/null || true
    fi
}

install_packages() {
    case "$OS" in
        fedora)
            install_packages_fedora
            ;;
        arch)
            install_packages_arch
            ;;
        debian)
            install_packages_debian
            ;;
        *)
            echo "Unsupported OS: $OS"
            exit 1
            ;;
    esac

    setup_docker
}

copy_configs() {
    echo "Copying config files..."

    mkdir -p "$HOME/.config"
    mkdir -p "$HOME/.local/bin"

    configs=(
        "btop"
        "mako"
        "fontconfig"
        "kitty"
        "lazygit"
        "nvim"
        "nvim.bak"
        "rofi"
        "sway"
        "swaync"
        "swaylock"
        "waybar"
    )

    for config in "${configs[@]}"; do
        if [ -d "$SCRIPT_DIR/configs/$config" ]; then
            if [ "$config" = "sway" ]; then
                echo "  Copying sway (swayfx)..."
            else
                echo "  Copying $config..."
            fi
            rm -rf "$HOME/.config/$config"
            cp -r "$SCRIPT_DIR/configs/$config" "$HOME/.config/$config"
        fi
    done

    echo "Copying bin scripts..."
    for script in "$SCRIPT_DIR/bin"/*; do
        if [ -f "$script" ]; then
            name=$(basename "$script")
            rm -f "$HOME/.local/bin/$name"
            cp "$script" "$HOME/.local/bin/$name"
            chmod +x "$HOME/.local/bin/$name"
        fi
    done

    echo "Copying .zshrc..."
    if [ -f "$SCRIPT_DIR/zsh/.zshrc" ]; then
        rm -f "$HOME/.zshrc"
        cp "$SCRIPT_DIR/zsh/.zshrc" "$HOME/.zshrc"
    fi
}

install_oh_my_zsh() {
    echo "Installing Oh My Zsh..."
    if [ ! -d "$HOME/.oh-my-zsh" ]; then
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    fi
    
    echo "Copying .zshrc..."
    cp "$SCRIPT_DIR/zsh/.zshrc" "$HOME/.zshrc"
    
    echo "Setting zsh as default shell..."
    chsh -s /usr/bin/zsh 2>/dev/null || echo "Could not change default shell. Run 'chsh -s /usr/bin/zsh' manually."
}

install_nvim_plugins() {
    echo "Installing Neovim plugins..."
    if command -v nvim &> /dev/null; then
        nvim --headless +Lazy! sync +qa 2>/dev/null || true
    fi
}

main() {
    echo ""
    echo "Select option:"
    echo "  1) Install packages only"
    echo "  2) Copy configs only"
    echo "  3) Full installation (packages + configs)"
    echo "  4) Exit"
    echo ""
    read -p "Enter choice [1-4]: " choice

    case "$choice" in
        1)
            install_packages
            ;;
        2)
            copy_configs
            install_oh_my_zsh
            install_nvim_plugins
            ;;
        3)
            install_packages
            copy_configs
            install_oh_my_zsh
            install_nvim_plugins
            echo ""
            echo "Installation complete! Restart your terminal to apply changes."
            ;;
        *)
            echo "Exiting..."
            exit 0
            ;;
    esac
}

main "$@"