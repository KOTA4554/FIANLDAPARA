
package com.kh.dpr.member.model.service;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.dpr.member.model.dao.MemberDAO;
import com.kh.dpr.member.model.vo.Member;

@Service
public class MemberServiceImpl implements MemberService {
	
	@Autowired
	MemberDAO memberDAO;

	@Override
	public int insertMember(Member member) {
		
		return memberDAO.insertMember(member);
	}

	@Override
	public Member selectOneMember(String userId) {
		return memberDAO.selectOneMember(userId);
	}

	@Override
	public int updateMember(Member member) {
		return memberDAO.updateMember(member);
	}

	@Override
	public int deleteMember(String userId) {
		return memberDAO.deleteMember(userId);
	}

	@Override
	public int checkIdDuplicate(String userId) {
		return memberDAO.checkIdDuplicate(userId);
	}
	

}

