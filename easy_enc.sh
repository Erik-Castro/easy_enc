#!/usr/bin/env bash
#
# Nome do Script: easy_enc.sh
# Autor: Erik Castro
# Data de Criação: 21 de Outubro de 2024
# Data da Última Modificação: 21 de Outubro de 2024
# Versão: 0.0.1-alpha
# Descrição: Ferramenta simples para encriptação de arquivos e dados utilizando OpenSSL.
# Dependências:
# --------------
# - OpenSSL 3.3.2 (Lançado em 3 de Setembro de 2024)
# =================================================
# AVISO LEGAL:
# ------------
# Ao utilizar este software, o usuário concorda que o autor não se responsabiliza por quaisquer danos resultantes do uso. A responsabilidade total pelo uso do software é do usuário.

# Verifica se as dependências estão instaladas
if ! command -v openssl &>/dev/null; then
    echo "[ERRO]: OpenSSL não está instalado. Instale o OpenSSL e tente novamente."
    exit 1
fi

# Variáveis de configuração
SAIDA="" # nome do arquivo gerado
PASSW="" # Senha para criptografia
METO="encrypt"
FILE=""

while [[ "$#" -gt 0 ]]; do
    case "$1" in
    -h)
        echo "Uso: $(basename $0) [-o arquivo_saida] [-p senha] [arquivo]"
        exit 0
        ;;
    -o)
        SAIDA="$2"
        shift
        ;;
    -p)
        PASSW=$(echo "$2" | sed 's/["\\]/\\&/g')
        shift
        ;;
    -d)
        METO="decrypt"
        ;;
    *)
        FILE="$1"
        ;;
    esac
    shift
done

# Função para encriptação
encriptar() {
    local arquivo="$1"
    local senha="$2"
    local flags="-a -salt -iter 2048 -pbkdf2 -pass pass:${senha} -aes-256-cbc"

    # Verifica qual é o método da operação (encriptação ou desencriptação)
    [[ "$METO" == "encrypt" ]] && flags="-e ${flags}" || flags="-d ${flags}"

    if [[ -n "$arquivo" ]]; then
        # Se um arquivo foi especificado, usa o arquivo como entrada
        if [[ -n "$SAIDA" ]]; then
            if openssl enc $flags -in "$arquivo" -out "$SAIDA"; then
                echo "Arquivo ${arquivo} criptografado com sucesso em ${SAIDA}!"
            else
                echo "[ERRO]: Falha na encriptação do arquivo ${arquivo}."
                exit 1
            fi
        else
            # Se SAIDA não foi especificado, escreve para a saída padrão (stdout)
            if openssl enc $flags -in "$arquivo"; then
                echo "Arquivo ${arquivo} criptografado com sucesso na saída padrão!"
            else
                echo "[ERRO]: Falha na encriptação do arquivo ${arquivo}."
                exit 1
            fi
        fi
    else
        # Se não foi especificado um arquivo, lê da entrada padrão
        if [[ -n "$SAIDA" ]]; then
            if openssl enc $flags -out "$SAIDA"; then
                echo "Dados criptografados com sucesso em ${SAIDA}!"
            else
                echo "[ERRO]: Falha na encriptação dos dados da entrada padrão."
                exit 1
            fi
        else
            # Se SAIDA não foi especificado, escreve para a saída padrão (stdout)
            if openssl enc $flags; then
                echo "Dados criptografados com sucesso na saída padrão!"
            else
                echo "[ERRO]: Falha na encriptação dos dados da entrada padrão."
                exit 1
            fi
        fi
    fi
}

# Solicita a senha se não foi fornecida
[[ -z "$PASSW" ]] && read -s -p "Digite a senha para encriptação: " PASSW </dev/tty
echo

# Verifica se o arquivo foi fornecido ou se a entrada padrão está sendo usada
if [[ -n "$FILE" && -f "$FILE" ]]; then
    encriptar "$FILE" "$PASSW"
elif [[ -z "$FILE" ]]; then
    # Se não foi fornecido um arquivo, usa a entrada padrão
    encriptar "" "$PASSW"
else
    echo "[ERRO]: O arquivo ${FILE} não existe!"
    exit 1
fi
