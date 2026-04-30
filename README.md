#**Jogo de Adivinhação**#

##**O que é este projeto?**##
Este é um jogo de adivinhação simples e divertido, construído com tecnologias modernas. Nele, um jogador cria um jogo definindo um número secreto entre 1 e 100. Outros jogadores tentam adivinhar esse número, recebendo dicas como "maior" ou "menor" a cada tentativa. O sistema registra os jogos e tentativas no banco de dados.

O projeto usa **Docker Compose** para rodar tudo de forma fácil: frontend em React, dois backends em Flask (para simular balanceamento de carga), banco PostgreSQL com persistência de dados e NGINX como proxy reverso.

##**Funcionalidades**##
- **Criar um jogo**: Defina seu número secreto e comece a receber tentativas.
- **Fazer tentativas**: Tente adivinhar o número de um jogo existente e veja as dicas.
- Todas as rotas da API estão disponíveis em /api (ex: /api/jogos, /api/tentativas).

##**Estrutura Geral**##
- **frontend**: Aplicação React servida pelo NGINX (container frontend).
- **backend1 e backend2**: Duas instâncias do Flask atrás do NGINX central (balanceamento automático).
- **db**: Banco PostgreSQL com volume para persistência de dados.
- **nginx**: Proxy reverso central que gerencia o tráfego para frontend e backends.

Tudo é orquestrado pelo arquivo docker-compose.yml.

##**Pré-requisitos**##
- Docker e Docker Compose instalados no seu computador.
- Pelo menos 2GB de RAM livre recomendados para rodar os containers.

##**Como Executar**##
1. Clone o repositório:

   git clone <URL_DO_REPOSITORIO>
   cd <NOME_DO_PROJETO>

2. Inicie os containers em modo detached (em background):
docker-compose up -d

3. Aguarde a inicialização (cerca de 1-2 minutos). Verifique os logs se necessário:
docker-compose logs -f

##**Como Acessar**##
Abra o navegador e acesse: http://localhost
O frontend estará disponível imediatamente após a inicialização.


##**Como Usar o Sistema**##

1. **Criar um jogo**:

    - Clique em "Criar Jogo".
    - Insira um número secreto (entre 1 e 100).
    - Clique em "Criar". Anote o ID do jogo para compartilhar.

2. **Fazer uma tentativa**:

    - Insira o ID do jogo.
    - Digite sua tentativa (número entre 1 e 100).
    - Clique em "Tentar". Veja a dica: "Acertou!", "Muito alto" ou "Muito baixo".

Os dados são salvos no banco e persistem mesmo ao reiniciar os containers.

##**Como Parar**##

Para parar todos os containers:
docker-compose down

Para parar e remover os volumes (perde os dados do banco):
docker-compose down -v


##**Observações Úteis**##

- **Persistência**: O banco PostgreSQL usa um volume Docker (postgres_data), então seus jogos e tentativas são mantidos ao reiniciar.
- **Variáveis de ambiente**: Os backends usam configs como FLASK_DB_NAME, etc., definidas no docker-compose.yml ou .env.
- **Frontend**: Configurado com REACT_APP_BACKEND_URL=/api para apontar para o NGINX.
- **Problemas comuns**:
    - Se o localhost não carregar, verifique docker-compose logs nginx ou backend1.
    - Portas em uso? Edite docker-compose.yml (padrão: 80 para web).

- **Instalação manual (opcional, avançado)**: Não recomendado para iniciantes. Use Docker sempre!