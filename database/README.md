# Desafio de Banco de Dados
  
Baseado no desafio proposto, foi desenvolvido utilizando o banco de dados PostgreSQL.  
Para facilitar, uma imagem docker foi disponibilizada para uso através do comando `docker-compose up --build`.  
Os dados de acesso são:  
1. Usuario: postgres
2. Senha: changeme
3. Banco: banking
4. Porta: 1234
  
  
Para a resolução do desafio, foram criados três arquivos para melhor organização e visualização. Para execução com sucesso do projeto, as queries precisam ser rodados na seguinte ordem (se não for utilizada a imagem docker):  
  
1. `1_structure.sql`: estrutura inicial do banco de dados, com as criações das tabelas e trigger/procedures.
2. `2_seed.sql`: dados iniciais para uso no banco de dados.  
3. `3_queries.sql`: queries utilizadas para extrair os dados no banco de dados conforme o desafio.  
  