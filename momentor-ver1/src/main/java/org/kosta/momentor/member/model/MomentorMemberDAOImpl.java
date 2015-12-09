package org.kosta.momentor.member.model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.kosta.momentor.contents.model.BoardVO;
import org.kosta.momentor.contents.model.ReplyVO;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class MomentorMemberDAOImpl implements MomentorMemberDAO {
	
	@Resource
	private SqlSessionTemplate sqlSessionTemplate;

	@Override
	public MomentorMemberVO managerFindMemberById(String id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public MomentorMemberVO managerFindMemberByNickName(String nickName) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<MomentorMemberVO> managerFindMemberByAddress(String address) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<MomentorMemberVO> managerFindMemberByName(String name) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public MomentorMemberPhysicalVO login(MomentorMemberVO vo) {
		return sqlSessionTemplate.selectOne("member.login", vo);
	}

	@Override
	public MomentorMemberVO updateMember(MomentorMemberVO vo) {
		return sqlSessionTemplate.selectOne("member.myPageMemberInfoUpdate",vo);
	}

	@Override
	public void registerMember(MomentorMemberVO vo) {
		sqlSessionTemplate.insert("member.registerMember",vo);
	}

	@Override
	public MomentorMemberVO idCheck(MomentorMemberVO vo){
		return sqlSessionTemplate.selectOne("member.idCheck",vo);
	}

	@Override
	public MomentorMemberVO passwordCheck(MomentorMemberVO vo){
		return sqlSessionTemplate.selectOne("member.passCheck",vo);
	}

	@Override
	public MomentorMemberVO findMemberById(String name, String email) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public MomentorMemberVO findMemberByPassword(String id, String name,
			String email) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public double bmi(MomentorMemberPhysicalVO vo) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public MomentorMemberVO deleteMemberByAdmin(String id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void deleteMemeber(MomentorMemberVO vo) {
		// TODO Auto-generated method stub
		
	}



	@Override
	public List<MomentorMemberVO> managerGetAllMember() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void registerPhysicalMember(MomentorMemberPhysicalVO pnvo) {
		sqlSessionTemplate.insert("member.registerPhysicalMember",pnvo);	
	}

	@Override
	public List<BoardVO> getMyCommnunityBoardList(Map<String, String> map) {
		
		
		
		return sqlSessionTemplate.selectList("content.getMyCommnunityBoardList", map);
	}

	@Override
	public List<ReplyVO> getMyReplyList(Map<String, String> map) {
	
		return sqlSessionTemplate.selectList("content.getMyReplyList", map);
	}
	
	   @Override
	   public int nickNameOverlappingCheck(String nickName) {
	      return sqlSessionTemplate.selectOne("member.nickNameOverlappingCheck",nickName);
	   }
	   @Override
	   public int idOverlappingCheck(String id) {
	      return sqlSessionTemplate.selectOne("member.idOverlappingCheck",id);
	   }

	@Override
	public int countAllMyCommnunityBoard(String memberId) {
		// TODO Auto-generated method stub
		return sqlSessionTemplate.selectOne("content.countAllMyCommnunityBoard", memberId);
	}

	@Override
	public int countAllMyReply(String memberId) {
		// TODO Auto-generated method stub
		return sqlSessionTemplate.selectOne("content.countAllMyReply", memberId);
	}

	@Override
	public int myPasswordCheck(String password) {
		return sqlSessionTemplate.selectOne("member.myPasswordCheck",password);
	}

	@Override
	public MomentorMemberPhysicalVO updateMemberPhysical(
			MomentorMemberPhysicalVO pnvo) {
		return sqlSessionTemplate.selectOne("member.myPageMemberPhysicalInfoUpdate",pnvo);	
	}

	@Override
	public void myPageDeleteMemberInfo(String memberId) {
		sqlSessionTemplate.selectOne("member.myPageDeleteMemberInfo", memberId);
		
	}

	@Override
	public void myPageDeleteMemberPhysicalInfo(String memberId) {
		sqlSessionTemplate.selectOne("member.myPageDeleteMemberPhysicalInfo", memberId);
		
	}

	@Override
	public MomentorMemberPhysicalVO myPageMemberInfo(String memberId) {
		return sqlSessionTemplate.selectOne("member.myPageMemberInfo", memberId);	
	}
}
