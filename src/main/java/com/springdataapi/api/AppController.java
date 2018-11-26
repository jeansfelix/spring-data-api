package com.springdataapi.api;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.springdataapi.model.Entidade;
import com.springdataapi.model.EntidadeRepository;

@Controller
@RequestMapping("/api")
public class AppController {
	@Autowired
	private EntidadeRepository entidadeRepository;

	@GetMapping("entidades")
	public @ResponseBody Iterable<Entidade> getEntidades() {
		return entidadeRepository.findAll();
	}
}
