package kr.or.ddit.member.vo;

import org.apache.ibatis.type.Alias;
import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.core.userdetails.User;

@Alias("UserTest")
public class MemberVOWrapper extends User {
	private MemberVO realMember;
	
	public MemberVOWrapper(MemberVO realMember) {
		super(realMember.getMemEmail(), realMember.getMemPass()
				, AuthorityUtils.createAuthorityList(realMember.getMemRole()));
		this.realMember = realMember;
	}
	
	public MemberVO getRealMember() {
		return realMember;
	}
	
//	@Override
//	public boolean isEnabled() {
//		return !realMember.isMailAuth();
//	}
}
