package com.nbp.myapp.util;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Component;

@Component
public class CommonUtil {

	
	//회원가입 및 로그인시의 필요한 비밀번호를 암호화
	public String PasswordEncoderGenerator(String password) {
		String hashedPassword = "";
		
		//비밀번호 인코딩
		if(password != null) {
			BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
			hashedPassword = passwordEncoder.encode(password);
		}
		
		return hashedPassword;
	}
	
	
	public String getXSSFilter(String value) {

		
	value = value.replaceAll("&", "&amp;");
	value = value.replaceAll("#", "&#35;");
	value = value.replaceAll(";", "&#59;");
	value = value.replaceAll("\\\\", "&#92;");
	value = value.replaceAll("<", "&lt;");
	value = value.replaceAll(">", "&gt;");
	value = value.replaceAll("\\(", "&#40;");
	value = value.replaceAll("\\)", "&#41;");
	value = value.replaceAll("'", "&#39;");
	value = value.replaceAll("\"", "&quot;");
	value = value.replaceAll("[$]", "&#36;");
	value = value.replaceAll("[*]", "&#42;");
	value = value.replaceAll("[+]", "&#43;");
	value = value.replaceAll("[|]", "&#124;");
	value = value.replaceAll("\\.", "&#46;");
	value = value.replaceAll("\\?", "&#63;");
	value = value.replaceAll("\\[", "&#91;");
	value = value.replaceAll("\\]", "&#93;");
	value = value.replaceAll("\\^", "&#94;");
	value = value.replaceAll("\\{", "&#123;");
	value = value.replaceAll("\\}", "&#125;");
	value = value.replaceAll("!", "&#33;");
	value = value.replaceAll("%", "&#37;");
	value = value.replaceAll(",", "&#44;");
	value = value.replaceAll("-", "&#45;");
	value = value.replaceAll("/", "&#47;");
	value = value.replaceAll(":", "&#58;");
	value = value.replaceAll("=", "&#61;");
	value = value.replaceAll("@", "&#64;");
	value = value.replaceAll("_", "&#95;");
	value = value.replaceAll("`", "&#96;");
	value = value.replaceAll("~", "&#126;");
		
		return value;

	}

	

}
