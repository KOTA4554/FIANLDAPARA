
package com.kh.dpr.member.model.dao;

import com.kh.dpr.member.model.vo.Member;

public interface MemberDAO {
	int insertMember(Member member);

	Member selectOneMember(String userId);

	int updateMember(Member member);

	int deleteMember(String userId);
	
	int checkIdDuplicate(String userId);

}

