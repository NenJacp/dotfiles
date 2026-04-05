#!/bin/bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

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

    sudo dnf install -y --skip-broken \
        zsh \
        neovim \
        btop \
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
        sway \
        swaylock \
        swayidle \
        waybar \
        mako

    install_lazygit_fedora
    setup_node_fedora
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

link_configs() {
    echo "Linking config files..."

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
            echo "  Linking $config..."
            rm -rf "$HOME/.config/$config"
            ln -sf "$SCRIPT_DIR/configs/$config" "$HOME/.config/$config"
        fi
    done

    echo "Linking bin scripts..."
    for script in "$SCRIPT_DIR/bin"/*; do
        if [ -f "$script" ]; then
            name=$(basename "$script")
            rm -f "$HOME/.local/bin/$name"
            ln -sf "$script" "$HOME/.local/bin/$name"
            chmod +x "$HOME/.local/bin/$name"
        fi
    done

    echo "Linking .zshrc..."
    if [ -f "$SCRIPT_DIR/zsh/.zshrc" ]; then
        rm -f "$HOME/.zshrc"
        ln -sf "$SCRIPT_DIR/zsh/.zshrc" "$HOME/.zshrc"
    fi
}

install_oh_my_zsh() {
    echo "Installing Oh My Zsh..."
    if [ ! -d "$HOME/.oh-my-zsh" ]; then
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    fi

    sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="af-magic"/' "$HOME/.zshrc"
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
    echo "  2) Link configs only"
    echo "  3) Full installation (packages + configs)"
    echo "  4) Exit"
    echo ""
    read -p "Enter choice [1-4]: " choice

    case "$choice" in
        1)
            install_packages
            ;;
        2)
            link_configs
            install_oh_my_zsh
            install_nvim_plugins
            ;;
        3)
            install_packages
            link_configs
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