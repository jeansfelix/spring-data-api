package com.springdataapi.config.security;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

public class SenhaEncoderUtil {
	public static void main(String[] args) {
		String encoded = new BCryptPasswordEncoder().encode("admin");
		System.out.println(encoded);
	}
}
