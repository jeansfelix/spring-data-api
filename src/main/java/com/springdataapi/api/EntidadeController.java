package com.springdataapi.api;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.springdataapi.model.exception.ResourceNotFoundException;
import com.springdataapi.model.jpa.Entidade;
import com.springdataapi.model.jpa.EntidadeRepository;

@Controller
@RequestMapping("/api")
public class EntidadeController {
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

		if (!entidades.iterator().hasNext())
			throw new ResourceNotFoundException("Nenhuma entidade retornada");
		
		for (Entidade entidade : entidades) {
			entidade.setEstado((String) getValue(entidade.getEntidadeId().toString()));
		}

		return entidades;
	}
	
	@GetMapping("entidades/{paramId}")
	public @ResponseBody Entidade getEntidade(@PathVariable String paramId) {
		Long id = Long.parseLong(paramId);
		
		Optional<Entidade> optionalEntidade = entidadeRepository.findById(id);
		
		if (!optionalEntidade.isPresent())
			throw new ResourceNotFoundException("Não existe entidade com id=" + paramId);
		
		Entidade entidade = entidadeRepository.findById(id).get();
		entidade.setEstado((String) getValue(paramId));
		
		return entidade;
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
			setValue(entidade.getEntidadeId(), novaEntidade.getEstado());
		}
		else {
			entidade = novaEntidade;
			entidade.setEntidadeId(id);
			entidade = entidadeRepository.save(entidade);
			
			entidade.setEstado(novaEntidade.getEstado());
			setValue(entidade.getEntidadeId(), novaEntidade.getEstado());
		}
		
		return entidade;
	}
}
