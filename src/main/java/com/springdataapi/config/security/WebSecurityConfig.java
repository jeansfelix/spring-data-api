package com.springdataapi.config.security;

import static com.springdataapi.config.security.Role.ADMINISTRADOR;
import static com.springdataapi.config.security.Role.USUARIO;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

@EnableWebSecurity
public class WebSecurityConfig extends WebSecurityConfigurerAdapter {

	@Autowired
	private DataSource dataSource;

	@Override
	protected void configure(AuthenticationManagerBuilder auth) throws Exception {

		auth.jdbcAuthentication().dataSource(dataSource)
				.usersByUsernameQuery("select nome, senha, habilitado from usuario where nome=?")
				.authoritiesByUsernameQuery("select usuario, perfil from permissao where usuario=?")
				.passwordEncoder(new BCryptPasswordEncoder());
	}

	@Override
	protected void configure(HttpSecurity http) throws Exception {
		http.csrf().disable().authorizeRequests().anyRequest().hasAnyRole(ADMINISTRADOR.name(), USUARIO.name()).and()
				.httpBasic().and().sessionManagement().disable();
	}
}