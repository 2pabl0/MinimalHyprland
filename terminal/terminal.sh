#!/bin/bash

set -e

# Directorio de copia de seguridad (lo exporta install.sh)
BACKUP_DIR="${BACKUP_DIR:-$(cd "$(dirname "$0")/.." && pwd)/copiaseguridad/manual}"
mkdir -p "$BACKUP_DIR"

# 1. ZSH como shell predeterminada
if [[ "$(echo "$SHELL" | awk -F/ '{print $NF}')" != "zsh" ]]; then
  chsh -s /bin/zsh
fi

# 2. Meto la configuracion de kitty
if [[ -e "$HOME/.config/kitty/" ]]; then
  mv ~/.config/kitty/ "$BACKUP_DIR/kitty"
fi
mkdir -p ~/.config/kitty/ && cp kitty.conf ~/.config/kitty/

# 3. Borro para asegurarme que no hay conflictos
if [[ -e "$HOME/.zshrc" ]]; then
  mv ~/.zshrc "$BACKUP_DIR/.zshrc"
fi

if [[ -e "$HOME/.oh-my-zsh" ]]; then
  mv ~/.oh-my-zsh "$BACKUP_DIR/.oh-my-zsh"
fi

if [[ -e "$HOME/.config/zsh" ]]; then
  mv ~/.config/zsh "$BACKUP_DIR/zsh"
fi

# 4. Instalo oh-my-zsh
curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -o /tmp/omz-install.sh
RUNZSH=no CHSH=no sh /tmp/omz-install.sh
rm -f /tmp/omz-install.sh

# 5. Instalo powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
sed -i '/ZSH_THEME=/c\ZSH_THEME="powerlevel10k/powerlevel10k"' ~/.zshrc

# 5.1 Instalo los plugins de sugerencias y resaltado de sintaxis
git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
sed -i 's/^plugins=(git)/plugins=(git zsh-autosuggestions zsh-syntax-highlighting)/' ~/.zshrc

# 6. Meto los alias
cat >>~/.zshrc <<'EOF'
# Alias de eza
alias ls='eza -l --color=always --group-directories-first --icons=always'
alias la='eza -l -a --color=always --group-directories-first --icons=always'
alias lt='eza --tree --level=2 --long --git --icons'
alias lta='lt -a'

# Atajos de fzf (Ctrl+R historial, Ctrl+T archivos)
source <(fzf --zsh)
EOF

# 7. Instalo LazyVim (starter oficial)
if [[ -e "$HOME/.config/nvim" ]]; then
  mv ~/.config/nvim "$BACKUP_DIR/nvim"
fi
git clone --depth=1 https://github.com/LazyVim/starter ~/.config/nvim
rm -rf ~/.config/nvim/.git
