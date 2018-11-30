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

Precisamos instalar o [mysql server](https://dev.mysql.com/downloads/mysql/).
Este será nosso banco de dados relacional e servirá para guardar os dados de usuario e as propriedades id e nome da classe Entidade.
É preciso configurar um usuário com o nome 'usuario' com as permissões 'CREATE', 'DROP', 'UPDATE', 'DELETE', 'INDEX'.
Para isto como admnistrador do banco execute os comandos abaixo:

```mysql
  CREATE DATABASE mydatabase;
  CREATE USER 'usuario'@'localhost' IDENTIFIED BY 'senha';
  GRANT CREATE, DROP, UPDATE, DELETE, INDEX PRIVILEGES ON mydatabase.* TO 'usuario'@'localhost';
```
Precisamos instalar o [redis-server](https://redis.io/topics/quickstart) que é o banco de dados baseado em mapas.

# Jmeter testes
Para executar os testes do 
