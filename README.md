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
* [redis-server]()

# Configuração de ambiente via puppet
em construção...

# Configuração manual de ambiente

Precisamos instalar o mysql-server podemos seguir este tutorial [mysql server_installation](https://dev.mysql.com/doc/mysql-apt-repo-quick-guide/en/).
Este será nosso banco de dados relacional e servirá para guardar os dados de usuario e as propriedades id e nome da classe Entidade.
É preciso configurar um usuário com o nome 'usuario' com as permissões 'CREATE', 'DROP', 'UPDATE', 'DELETE', 'INDEX'.
Para isto como admnistrador do banco execute os comandos abaixo:
```mysql
  CREATE DATABASE mydatabase;
  CREATE USER 'usuario'@'localhost' IDENTIFIED BY 'senha';
  GRANT CREATE, DROP, UPDATE, DELETE, INDEX PRIVILEGES ON mydatabase.* TO 'usuario'@'localhost';
```

Precisamos instalar o [redis-server](https://redis.io/topics/quickstart) que é o banco de dados baseado em mapas.
Ele servirá para guardar a propriedade estado da classe Entidade.
Podemos utilizar a instalação padrão do redis-server seguindo o tutorial deste link: [redis-server-installation](https://redis.io/topics/quickstart)

# Jmeter testes
Para executar os testes do Jmeter basta importar o arquivo de teste da pasta [teste-de-carga](https://github.com/jeansfelix/spring-data-api/tree/master/teste-de-carga) e configurar a url e porta do servidor adequadamente em 'HTTP Request Defaults'.

![HTTP Request Defaults](http://oi64.tinypic.com/ortiz8.jpg)

Os testes estão configurados para rodar com 1000 threads para os usuários que ficaram durante 10 segundos cada uma executando 10 requests.



