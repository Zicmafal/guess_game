# Jogo de Adivinhação

## O que é este projeto?  

Este é um simples e divertido jogo de adivinhação desenvolvido utilizando o framework Flask. O jogador deve adivinhar uma palavra criada aleatoriamente, e o sistema fornecerá feedback sobre o número de letras corretas e suas respectivas posições.

O projeto usa **Docker Compose** para rodar tudo de forma fácil: frontend em React, dois backends em Flask (para simular balanceamento de carga), banco PostgreSQL com persistência de dados e NGINX como proxy reverso.


## Funcionalidades
- **Criar um jogo**: Defina sua palavra secreta e comece a receber tentativas.
- **Fazer tentativas**: Tente adivinhar a palavra de um jogo existente e veja as dicas.


## Estrutura Geral
- **frontend**: Aplicação React servida pelo NGINX (container frontend).
- **backend1 e backend2**: Duas instâncias do Flask atrás do NGINX central (balanceamento automático).
- **db**: Banco PostgreSQL com volume para persistência de dados.
- **nginx**: Proxy reverso central que gerencia o tráfego para frontend e backends.

Tudo é orquestrado pelo arquivo docker-compose.yml. 


## Pré-requisitos
- Docker e Docker Compose instalados no seu computador.
- Pelo menos 2GB de RAM livre recomendados para rodar os containers.


## Como Executar
1. Clone o repositório:

   git clone <https://github.com/Zicmafal/guess_game.git> 

   cd guess_game

2. Inicie os containers em modo detached (em background): 

docker compose up -d

3. Aguarde a inicialização (cerca de 1-2 minutos). Verifique os logs se necessário:
docker compose logs -f


## Como Acessar
Abra o navegador e acesse: http://localhost  
O frontend estará disponível imediatamente após a inicialização.
 

## Como Usar o Sistema

1. **Criar um jogo**:

    - Clique em "Create a Game" ou "Maker".
    - Insira uma palavra secreta.
    - Clique em "Create Game". Anote o ID do jogo para compartilhar.

2. **Fazer uma tentativa**:

    - Clique em "Join a Game" ou "Breaker".
    - Insira o ID do jogo.
    - Digite sua tentativa em "your Guess".
    - Clique em "Submit Guess". 
    - Veja as dicas.

Os dados são salvos no banco e persistem mesmo ao reiniciar os containers. 


## Como Parar

Para parar todos os containers:   
docker compose down

Para parar e remover os volumes (perde os dados do banco):  
docker compose down -v 


## Atualização dos componentes

Uma das vantagens desta estrutura é que cada serviço pode ser atualizado de forma independente, apenas trocando a versão da imagem Docker no arquivo **docker-compose.yml**.  
No caso do **backend Flask**, basta alterar a tag da imagem utilizada no serviço correspondente.
O mesmo vale para o **frontend React servido pelo NGINX**, para o próprio **NGINX** e para o **PostgreSQL**.
Isso significa que, para atualizar qualquer componente, não é necessário modificar toda a estrutura do projeto. Em geral, a atualização acontece apenas substituindo a versão da imagem e recriando os containers.
Exemplo prático:
- antes: image: nome-da-imagem:v1
- depois: image: nome-da-imagem:v2  
Após alterar a versão da imagem, basta executar novamente os comandos de subida dos containers para aplicar a nova versão. Essa abordagem facilita a manutenção do projeto e permite atualizar backend, frontend e banco de dados de forma simples e organizada.


## Observações Úteis

- **Persistência**: O banco PostgreSQL usa um volume Docker (postgres_data), então seus jogos e tentativas são mantidos ao reiniciar.
- **Variáveis de ambiente**: Os backends usam configs como FLASK_DB_NAME, etc., definidas no docker-compose.yml ou .env.
- **Frontend**: Configurado com REACT_APP_BACKEND_URL=/api para apontar para o NGINX.
- **Problemas comuns**:
    - Se o localhost não carregar, verifique docker-compose logs nginx ou backend1.
    - Portas em uso? Edite docker-compose.yml (padrão: 80 para web).

- **Instalação manual (opcional, avançado)**: Não recomendado para iniciantes. Use Docker sempre!
