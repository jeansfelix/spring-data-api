CREATE TABLE IF NOT EXISTS usuario(
	usuario_id BIGINT NOT NULL AUTO_INCREMENT,
	nome VARCHAR(100) NOT NULL,
	senha VARCHAR(50) NOT NULL,
	PRIMARY KEY (usuario_id),
	UNIQUE KEY (nome)
);

CREATE TABLE IF NOT EXISTS usuario_permissao(
	usuario_permissao_id BIGINT NOT NULL AUTO_INCREMENT,
	usuario_id BIGINT NOT NULL,
	permissao VARCHAR(100) NOT NULL,
	PRIMARY KEY (usuario_permissao_id),
	UNIQUE KEY (usuario_id,permissao),
	CONSTRAINT FK_USUARIO FOREIGN KEY (usuario_id) REFERENCES usuario (usuario_id)
);


CREATE TABLE IF NOT EXISTS entidade (
    entidade_id BIGINT NOT NULL AUTO_INCREMENT, 
    nome VARCHAR(100) NOT NULL, 
    PRIMARY KEY(entidade_id)
);