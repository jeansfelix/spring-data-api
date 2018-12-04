create table IF NOT EXISTS usuario(
	nome varchar(50) not null primary key,
	senha varchar(100) not null,
	habilitado boolean not null
);
create table IF NOT EXISTS permissao (
	usuario varchar(50) not null,
	perfil varchar(50) not null,
	unique key (usuario, perfil),
	constraint fk_permissao_usuario foreign key(usuario) references usuario(nome)
);

CREATE TABLE IF NOT EXISTS entidade (
    entidade_id BIGINT NOT NULL AUTO_INCREMENT, 
    nome VARCHAR(100) NOT NULL, 
    PRIMARY KEY(entidade_id)
);
