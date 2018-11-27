package com.springdataapi.model.jpa;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Transient;

@Entity
public class Entidade {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long entidadeId;

	private String nome;

	@Transient
	private String estado;

	public Long getEntidadeId() {
		return entidadeId;
	}

	public void setEntidadeId(Long entidadeId) {
		this.entidadeId = entidadeId;
	}

	public String getNome() {
		return nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}
	
	public String getEstado() {
		return estado;
	}

	public void setEstado(String estado) {
		this.estado = estado;
	}
}
