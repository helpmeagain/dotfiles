#!/bin/bash

EXTENSIONS_FILE="$HOME/.config/Code/User/extensions.txt"

function export_extensions() {
    echo "Exportando extensões do VS Code para $EXTENSIONS_FILE..."
    code --list-extensions > "$EXTENSIONS_FILE"
    echo "Exportação concluída!"
}

function import_extensions() {
    if [ -f "$EXTENSIONS_FILE" ]; then
        echo "Instalando extensões do VS Code..."
        cat "$EXTENSIONS_FILE" | xargs -L 1 code --install-extension
        echo "Todas as extensões foram instaladas!"
    else
        echo "Arquivo $EXTENSIONS_FILE não encontrado."
    fi
}

case "$1" in
    export)
        export_extensions
        ;;
    import)
        import_extensions
        ;;
    *)
        echo "Uso: ./extensions_manager.sh [export|import]"
        ;;
esac