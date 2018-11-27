package com.springdataapi.api;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.springdataapi.model.jpa.Entidade;
import com.springdataapi.model.jpa.EntidadeRepository;

@Controller
@RequestMapping("/api")
public class AppController {
	@Autowired
	private EntidadeRepository entidadeRepository;

	@Autowired
	private RedisTemplate<String, Object> template;

	public Object getValue(final String key) {
		return template.opsForValue().get(key);
	}

	public void setValue(final Long key, final String value) {
		template.opsForValue().set(key.toString(), value);
	}

	@GetMapping("entidades")
	public @ResponseBody Iterable<Entidade> getEntidades() {
		Iterable<Entidade> entidades = entidadeRepository.findAll();

		for (Entidade entidade : entidades) {
			entidade.setEstado((String) getValue(entidade.getId().toString()));
		}

		return entidades;
	}
	
	@GetMapping("entidades/{id}")
	public @ResponseBody Iterable<Entidade> getEntidade() {
		Iterable<Entidade> entidades = entidadeRepository.findAll();

		return entidades;
	}

	@PutMapping("entidades/{paramId}")
	public @ResponseBody Entidade updateEntidade(@RequestBody Entidade novaEntidade, @PathVariable String paramId) {
		Long id = Long.parseLong(paramId);
		
		Entidade entidade;
		
		if (entidadeRepository.existsById(id)) 
		{
			entidade = entidadeRepository.findById(id).get();
			entidade.setNome(novaEntidade.getNome());
			entidadeRepository.save(entidade);
			
			entidade.setEstado(novaEntidade.getEstado());
			setValue(entidade.getId(), novaEntidade.getEstado());
		}
		else {
			entidade = novaEntidade;
			entidade.setId(id);
			entidade = entidadeRepository.save(entidade);
			
			entidade.setEstado(novaEntidade.getEstado());
			setValue(entidade.getId(), novaEntidade.getEstado());
		}
		
		return entidade;
	}
}
