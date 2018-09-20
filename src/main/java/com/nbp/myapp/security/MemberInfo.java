package com.nbp.myapp.security;

import java.util.Collection;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Component;

//유저의 정보를 세션에 담기 위해 스프링 시큐리티에서 제공하는 UserDetails를 구현함

public class MemberInfo implements UserDetails {
	private String MEMBER_KEY;
	private String MEMBER_ID;
	private String MEMBER_NAME;
	private String MEMBER_PASSWORD;
	private String MEMBER_ADDR;
	private String MEMBER_TEL;
	
	
	private String myMarkingCount;
	private List myGradeList;


	private Set<GrantedAuthority> authorities;

	public MemberInfo(Map<String, Object> resultMember, Set<GrantedAuthority> authorities) {
		this.MEMBER_ID = (String) resultMember.get("MEMBER_ID");
		this.MEMBER_NAME = (String) resultMember.get("MEMBER_NAME");
		this.MEMBER_PASSWORD = (String) resultMember.get("MEMBER_PASSWORD");
		this.MEMBER_KEY = (String) (resultMember.get("MEMBER_KEY").toString());
		this.MEMBER_ADDR = (String) resultMember.get("MEMBER_ADDR");
		this.MEMBER_TEL = (String) resultMember.get("MEMBER_TEL");
		
		this.myGradeList = (List)resultMember.get("MY_GRADE_LIST");
		this.myMarkingCount = resultMember.get("MY_MARKING_COUNT").toString();
		this.authorities = authorities;
	}

	public void setMyMarkingCount(String myMarkingCount) {
		this.myMarkingCount = myMarkingCount;
	}

	public Collection<? extends GrantedAuthority> getAuthorities() {
		// TODO Auto-generated method stub
		return authorities;
	}

	public String getPassword() {
		// TODO Auto-generated method stub
		return MEMBER_PASSWORD;
	}

	public String getUsername() {
		// TODO Auto-generated method stub
		return MEMBER_ID;
	}

	public String getMemberName() {
		return MEMBER_NAME;
	}

	public String getMEMBER_KEY() {
		return MEMBER_KEY;
	}

	public String getMyMarkingCount() {
		return myMarkingCount;
	}

	public boolean isAccountNonExpired() {
		// TODO Auto-generated method stub
		return true;
	}

	public boolean isAccountNonLocked() {
		// TODO Auto-generated method stub
		return true;
	}

	public boolean isCredentialsNonExpired() {
		// TODO Auto-generated method stub
		return true;
	}

	public boolean isEnabled() {
		// TODO Auto-generated method stub
		return true;
	}

	public String getMEMBER_ADDR() {
		return MEMBER_ADDR;
	}

	public String getMEMBER_TEL() {
		return MEMBER_TEL;
	}
	public List getMyGradeList() {
		return myGradeList;
	}

	public void setMyGradeList(List myGradeList) {
		this.myGradeList = myGradeList;
	}

}
