delete from permissao;
delete from usuario;

insert into usuario(nome, senha, habilitado)
	values('admin','$2a$10$ND4QwRwaK3ETRZYD/3SEqOaJII0u6QSEonF8Wb/S00R1PWO7QgaBq',true);
insert into permissao(usuario, perfil) 
	values('admin','ROLE_ADMINISTRADOR');