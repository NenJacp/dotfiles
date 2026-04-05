# Dotfiles

Mis dotfiles para replicar mi entorno de trabajo en nuevas máquinas.

## Requisitos

- **OS**: Fedora 43+ (soporte para Arch/Debian en desarrollo)
- **Usuario**: Acceso sudo

## Instalación

```bash
# Clonar el repositorio
git clone git@github.com:NenJacp/dotfiles.git
cd dotfiles

# Ejecutar el instalador
./install.sh
```

### Opciones de instalación

1. **Instalar solo paquetes** - Instala todo el software necesario
2. **Copiar solo configs** - Solo copiar configuraciones a ~/.config/
3. **Instalación completa** - Paquetes + configs

## Paquetes instalados

### Software principal
- `zsh` - Shell con Oh My Zsh (tema af-magic)
- `neovim` - Editor con LazyVim
- `kitty` - Terminal
- `swayfx` - Window Manager (desde COPR)
- `fastfetch` - Tool de info del sistema
- `docker-ce` - Contenedores

### Utilidades
- `btop` - Monitor del sistema
- `rofi` - Launcher
- `mako` - Notificaciones
- `waybar` - Barra de estado
- `lazygit` - UI para git
- `grim` + `slurp` - Screenshots

### Fuentes
- Noto Sans (sistema y sway)

## Estructura

```
dotfiles/
├── install.sh          # Script de instalación
├── configs/             # Configuraciones
│   ├── btop/          # Monitor sistema
│   ├── mako/          # Notificaciones
│   ├── fontconfig/   # Fuentes
│   ├── kitty/        # Terminal
│   ├── lazygit/      # Git UI
│   ├── nvim/         # Neovim (LazyVim)
│   ├── nvim.bak/     # Backup Neovim
│   ├── rofi/         # Launcher
│   ├── sway/         # WM config
│   ├── swaync/       # Notificaciones sway
│   ├── swaylock/     # Lock screen
│   └── waybar/       # Status bar
├── bin/                # Scripts locales
└── zsh/
    └── .zshrc        # Config zsh
```

## Configuraciones importantes

### Sway
- Usa **swayfx** (fork de sway con mejoras)
- Font: JetBrains Mono Nerd Font 10pt
- Configuración modular en `~/.config/sway/keys/`, `appearance/`, etc.

### Kitty
- Font: Noto Sans
- Tema: Oxocarbon dark
- Tamaño: 10pt

### Neovim
- LazyVim con múltiples plugins
- LSP configurado
- Tema: oxocarbon

## Scripts locales (`~/.local/bin/`)

- `brightness` - Control de brillo
- `volume` - Control de volumen
- `screenshot` - Capturas de pantalla
- `powermenu` - Menú de energía
- `recorder` - Grabador de pantalla

## Notas

- Los secrets (API keys, tokens) están comentados en `.zshrc`
- Requiere reiniciar sesión después de instalado para que zsh sea el shell por defecto
- Para iniciar sway: `sway` o `swayfx` desde TTY

## Actualizar dotfiles

```bash
cd dotfiles
git add .
git commit -m "Actualización"
git push
```

## Inspiración

- Tema de zsh: af-magic
- Colores: Oxocarbon
- Font: JetBrains Mono Nerd Font