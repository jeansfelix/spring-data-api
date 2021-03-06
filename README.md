# spring-data-api

Este serviço visa utilizar spring-data para gerenciar uma entidade utilizando duas fontes de dados distintas (mysql , redis).

# Lista de tecnologias

* [spring-boot](https://spring.io/projects/spring-boot)
* * [spring-security](https://spring.io/projects/spring-security)
* * [spring-data-redis](https://spring.io/projects/spring-data-redis)
* * [spring-data-jpa](https://spring.io/projects/spring-data-jpa)
* * [spring-rest](https://spring.io/guides/gs/rest-service/)
* [mysql](https://dev.mysql.com/downloads/mysql/)
* [puppet (master/agent)](https://puppet.com/docs/puppet/5.3/quick_start_master_agent_communication.html)
* [bash (init-script)](https://pt.wikipedia.org/wiki/Shell_script)
* [Maven](https://maven.apache.org/install.html)
* [redis-server](https://redis.io/documentation)

# API

A api deste repositório serve para alterar os valores de uma entidade chamada Entidade que possui um id incremental, um campo para o nome e um valor de estado. 

Entidade {
  "id": 1,
  "nome": "entidade1",
  "estado": "ativa",
}

Para acessarmos a api precisamos de um usuário com o perfil de "USUARIO" ou de "ADMINISTRADOR" cadastrado no banco de dados. Em toda requisição é necessário passar o Header HTTP Authorization com o valor "Basic xxxxxxxxxxx" onde o 'xxxxxxxxxxx' deve ser o base64 do texto composto por usuário e senha desta forma: 'usuario:senha'. Caso não seja passado este header o response da requisão será 401 Unauthorized em qualquer endpoint.

## Listar entidades:
Lista as entidades todas as entidades presentes.

* **URL :** /api/entidades

* **Parâmetros da URL :** nenhum

* **Método HTTP :** GET

* **Requer Autenticacao :** SIM

* **Requer Permissão :** USUARIO ou ADMINISTRADOR

* **Dados Retornados :** 
```json
[{
    "entidadeId":1,
    "nome":"nomeentidade1",
    "estado":"estado1",
 },
 {  
    "entidadeId":2,
    "nome":"nomeentidade2",
    "estado":"estado2"
}]
```

* **Código do http status response :** 200 ok ou 201 no content

## Recuperar entidade específica
Recupera uma entidade específica pelo seu id.

* **URL :** /api/entidades/:entidadeId

* **Parâmetros da URL :** recebe o id da entidade que se deseja recuperar

* **Método HTTP :** GET

* **Requer Autenticacao :** SIM

* **Requer Permissão :** USUARIO ou ADMINISTRADOR

* **Dados Retornados :**  
```json
{
    "entidadeId":idEntidade1,
    "nome":"nomeentidade1",
    "estado":"estado1",
}
```

* **Código do http status response :** 200 ok

## Criar entidade

Cria uma entidade nova e a retorna.

* **URL :** /api/entidades

* **Parâmetros da URL :** nenhum. 

* **Método HTTP :** POST

* **Requer Autenticacao :** SIM

* **Requer Permissão :** USUARIO ou ADMINISTRADOR

* **Dados Enviados :** 
```json
{
    "nome":"nomeentidade",
    "estado":"estado",
}
```

* **Dados Retornados :** 
```json
{
    "entidadeId": idGerado,
    "nome":"nomeentidade",
    "estado":"estado",
}
```

* **Código do http status response :** 201 created 

## Alterar entidade

Altera dados de uma entidade específica através do seu id.

* **URL :** /api/entidades/:entidadeId

* **Parâmetros da URL :** recebe o id da entidade que se deseja alterar 

* **Método HTTP :** POST

* **Requer Autenticacao :** SIM

* **Requer Permissão :** USUARIO ou ADMINISTRADOR

* **Dados Enviados :** 
```json
{
    "nome":"nomeentidade",
    "estado":"estado",
}
```

* **Dados Retornados :** 
```json
{
    "entidadeId": idGerado,
    "nome":"nomeentidade",
    "estado":"estado",
}
```

* **Código do http status response :** 200 ok

# Build manual

Para gerarmos o artefato do projeto basta utilizarmos o [wrapper do maven](https://github.com/takari/maven-wrapper) executarmos o comando:`./mvnw package`.
Este comando irá gerar um jar com todas as dependencias necessárias na pasta /target. 
Para subirmos o servidor basta executarmos este jar com o comando: `java -jar spring-data-api.jar`

# Configuração manual de ambiente

Precisamos instalar o mysql-server podemos seguir este tutorial [mysql server_installation](https://dev.mysql.com/doc/mysql-apt-repo-quick-guide/en/).
Este será nosso banco de dados relacional e servirá para guardar os dados de usuario e as propriedades id e nome da classe Entidade.
É preciso configurar um usuário com o nome 'usuario' com as permissões 'SELECT', 'CREATE', 'DROP', 'INSERT', 'UPDATE', 'DELETE' and 'INDEX'.
Para isto como admnistrador do banco execute os comandos abaixo:
```mysql
  CREATE DATABASE mydatabase;
  CREATE USER 'usuario'@'localhost' IDENTIFIED BY 'senha';
  GRANT SELECT, CREATE, DROP, INSERT, UPDATE, DELETE, INDEX PRIVILEGES ON mydatabase.* TO 'usuario'@'localhost';
```

Precisamos instalar o [redis-server](https://redis.io/topics/quickstart) que é o banco de dados baseado em mapas.
Ele servirá para guardar a propriedade estado da classe Entidade.
Podemos utilizar a instalação padrão do redis-server seguindo o tutorial deste link: [redis-server-installation](https://redis.io/topics/quickstart)

### init-script

Para executarmos o serviço podemos utilizar o script de inicialização do diretório [init-script](https://github.com/jeansfelix/spring-data-api/tree/master/init-script). 
Por padrão ele utiliza o diretório **/opt/spring-data-api** para guardar o spring-data-api.jar. 
Possui as opções restart, start, stop, status.

# Jmeter testes
Para executar os testes do Jmeter basta importar o arquivos jmx em cada cenário de teste da pasta [teste-de-carga](https://github.com/jeansfelix/spring-data-api/tree/master/teste-de-carga) e configurar a url e porta do servidor adequadamente em 'HTTP Request Defaults'.

![HTTP Request Defaults](http://oi64.tinypic.com/ortiz8.jpg)

Foi utilizado um cenário com três diferentes número de usuários para os testes. 

No cenário cada usuário realiza um GET para o endpoint /api/entidades e listam as 10 entidades presentes no banco de dados.

* O primeiro foi utilizar 1000 threads e repetir 10 vezes.
* O segundo foi utilizar 2000 threads e repetir 5 vezes.
* O terceiro foi utilizar 10000 threads e repetir apenas 1 vez.

Nos dois primeiros cenários não houveram erros no response. No terceiro cenário foi observado 0.37% de erro.
Os relatórios em html gerados pelo jmeter se encontram no diretório [teste-de-carga](https://github.com/jeansfelix/spring-data-api/tree/master/teste-de-carga)

# Configuração de ambiente via puppet
Os arquivos do puppet neste repositório são arquivos que devem estar no servidor(master) e se referem a arquitetura [client-server](https://puppet.com/docs/puppet/5.5/architecture.html) do puppet.

Para configurar o seu ambiente via puppet basta copiar os dados da pasta production em [puppet_files](https://github.com/jeansfelix/spring-data-api/tree/master/puppet-files) para a pasta correspondente no servidor do puppet e instalar os modulos do puppet que estão descritos no arquivo [necessario_instalar](https://github.com/jeansfelix/spring-data-api/blob/master/puppet-files/necessario_instalar). Feito isto, verifique em qual node você quer configurar o app e edit o [init.pp](https://github.com/jeansfelix/spring-data-api/blob/master/puppet-files/production/manifests/init.pp). 

A ISO base para criação do servidor foi um [Debian 9](https://www.debian.org/CD/netinst/) e durante a instalação foi selecionado SSH_server e webserver como configurações iniciais. Após criar a máquina basta configurar o cliente do puppet para se comunicar com o servidor e executar as configurações adicionais.


