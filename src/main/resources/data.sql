delete from usuario_permissao;
delete from usuario;

INSERT INTO usuario (usuario_id, nome, senha)
VALUES (1, 'usuario', 'usuario');

INSERT INTO usuario (usuario_id, nome, senha)
VALUES (2, 'admin', 'admin');

INSERT INTO usuario_permissao (usuario_permissao_id, usuario_id, permissao)
VALUES (1, 1, 'USUARIO');

INSERT INTO usuario_permissao (usuario_permissao_id, usuario_id, permissao)
VALUES (2, 2, 'ADMINISTRADOR');