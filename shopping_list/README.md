# Desafio e tecnologias envolvidas 
  
Para a resolução do desafio proposto, foi utilizado a linguagem Elixir v1.13.  
A estrutura de pastas/arquivos é realizada do seguinte modo:  
1. `./lib/`: pasta onde existem os arquivos relacionados à implementação do desafio proposto  
2. `./lib/shopping_list.ex`: interface que expõe os métodos públicos da interface.
3. `./lib/impl/`: pasta onde existem as implementações internas da calculadora de lista de compras
4. `./lib/type.ex`: arquivo que reúne as tipagens do projeto
5. `./test/`: pasta que contém os testes unitários do projeto
  
# Como rodar o projeto?  
  
Visando uma maior praticidade ao rodar o projeto, foi disponibilizada uma imagem docker, que pode ser rodada através do comando: `docker-compose up --build`
  
A imagem compila as dependências e roda o comando: `mix test` que é responsável por rodar os testes unitàrios.
  
