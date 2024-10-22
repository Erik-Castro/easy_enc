# easy_enc.sh

## Descrição

O `easy_enc.sh` é uma ferramenta simples e eficaz para encriptação e desencriptação de arquivos e dados utilizando a biblioteca OpenSSL. Desenvolvido por Erik Castro, este script permite que usuários protejam suas informações sensíveis de forma rápida e prática, utilizando algoritmos de criptografia robustos.

## Funcionalidades

- **Encriptação e Desencriptação**: Suporte para encriptar e desencriptar arquivos e dados diretamente do terminal.
- **Configuração Flexível**: Permite especificar o arquivo de saída e a senha para criptografia através de parâmetros de linha de comando.
- **Uso de OpenSSL**: Baseado na poderosa biblioteca OpenSSL, garantindo segurança e confiabilidade.

## Dependências

- OpenSSL 3.3.2 ou superior (Lançado em 3 de Setembro de 2024)

## Como Usar

1. **Clone o repositório**:
   ```bash
   git clone https://github.com/seu_usuario/easy_enc.git
   cd easy_enc
   ```

2. **Dê permissão de execução ao script**:
   ```bash
   chmod +x easy_enc.sh
   ```

3. **Execute o script**:
   ```bash
   ./easy_enc.sh -o arquivo_saida -p sua_senha arquivo_entrada
   ```

   Para desencriptar, utilize a opção `-d`:
   ```bash
   ./easy_enc.sh -d -o arquivo_saida -p sua_senha arquivo_encriptado
   ```

## Aviso Legal

Ao utilizar este software, o usuário concorda que o autor não se responsabiliza por quaisquer danos resultantes do uso. A responsabilidade total pelo uso do software é do usuário.

## Contribuições

Contribuições são bem-vindas! Sinta-se à vontade para abrir issues ou pull requests para melhorias e correções.

## Licença

Este projeto está licenciado sob a [Licença MIT](LICENSE).