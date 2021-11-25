
package com.kh.dpr.member.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.dpr.member.model.vo.Member;

@Repository
public class MemberDAOImpl implements MemberDAO {
	
	@Autowired
	SqlSessionTemplate sqlSession;

	@Override
	public int insertMember(Member member) {
		
		return sqlSession.insert("memberSQL.insertMember", member);
	}

	@Override
	public Member selectOneMember(String userId) {
		return sqlSession.selectOne("memberSQL.selectMember", userId);
	}

	@Override
	public int updateMember(Member member) {
		return sqlSession.update("memberSQL.updateMember", member);
	}

	@Override
	public int deleteMember(String userId) {
		return sqlSession.delete("memberSQL.deleteMember", userId);
	}

	@Override
	public int checkIdDuplicate(String userId) {
		return sqlSession.selectOne("memberSQL.checkIdDuplicate", userId);
	}
	
}

