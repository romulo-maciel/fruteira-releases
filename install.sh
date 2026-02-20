#!/bin/bash
echo "Preparando a instalação do Sistema NSA..."

REPO="romulo-maciel/fruteira-releases"
APP_DIR="$HOME/.fruteiraerp"

mkdir -p "$APP_DIR"

echo "Baixando arquivos de atalho..."
wget -qO "$APP_DIR/launcher.sh" "https://raw.githubusercontent.com/$REPO/main/launcher.sh"
wget -qO "$APP_DIR/icon.png" "https://raw.githubusercontent.com/$REPO/main/icon.png"
chmod +x "$APP_DIR/launcher.sh"

echo "Criando atalhos no sistema..."
DESKTOP_FILE="$HOME/.local/share/applications/fruteiraerp.desktop"

cat > "$DESKTOP_FILE" << EOF
[Desktop Entry]
Version=1.0
Name=Fruteira ERP
Comment=Sistema de Gestão
Exec=$APP_DIR/launcher.sh
Icon=$APP_DIR/icon.png
Terminal=false
Type=Application
Categories=Office;Finance;
EOF

# Tenta copiar para a Área de Trabalho (funciona em português ou inglês)
cp "$DESKTOP_FILE" "$HOME/Área de Trabalho/" 2>/dev/null || cp "$DESKTOP_FILE" "$HOME/Desktop/" 2>/dev/null
chmod +x "$HOME/Área de Trabalho/fruteiraerp.desktop" 2>/dev/null || chmod +x "$HOME/Desktop/fruteiraerp.desktop" 2>/dev/null

echo "Instalação concluída! O sistema abrirá agora para baixar a versão mais recente..."
sleep 2

# Executa o launcher pela primeira vez para baixar o AppImage
"$APP_DIR/launcher.sh"
