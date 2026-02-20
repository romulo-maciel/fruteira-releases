#!/bin/bash

APP_DIR="$HOME/.fruteiraerp"
APPIMAGE="$APP_DIR/FruteiraERP.AppImage"
VERSION_FILE="$APP_DIR/version.txt"

# Configurações do seu repo público
REPO="romulo-maciel/fruteira-releases"
URL_VERSION="https://raw.githubusercontent.com/$REPO/main/version.txt"
# O GitHub sempre redireciona este link 'latest' para o AppImage mais recente
URL_APPIMAGE="https://github.com/$REPO/releases/latest/download/FruteiraERP-x86_64.AppImage"

# Verifica versão online
ONLINE_VERSION=$(wget -qO- "$URL_VERSION" --timeout=3)
LOCAL_VERSION=$(cat "$VERSION_FILE" 2>/dev/null || echo "0.0.0")

if [ -n "$ONLINE_VERSION" ] && [ "$ONLINE_VERSION" != "$LOCAL_VERSION" ]; then
    zenity --info --text="Nova versão encontrada ($ONLINE_VERSION). Atualizando o sistema..." --timeout=3 2>/dev/null || true
    
    # Baixa a nova versão
    wget -q --show-progress -O "$APPIMAGE.new" "$URL_APPIMAGE"
    
    if [ $? -eq 0 ]; then
        mv "$APPIMAGE.new" "$APPIMAGE"
        chmod +x "$APPIMAGE"
        echo "$ONLINE_VERSION" > "$VERSION_FILE"
    fi
fi

# Executa o sistema
if [ -f "$APPIMAGE" ]; then
    "$APPIMAGE" "$@"
else
    zenity --error --text="Sistema não encontrado. Conecte-se à internet e tente novamente." 2>/dev/null
fi
