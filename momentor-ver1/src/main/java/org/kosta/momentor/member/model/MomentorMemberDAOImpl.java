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
	public MomentorMemberPhysicalVO login(MomentorMemberVO vo) {
		return sqlSessionTemplate.selectOne("member.login", vo);
	}
	@Override
	public MomentorMemberVO idCheck(MomentorMemberVO vo){
		return sqlSessionTemplate.selectOne("member.idCheck", vo);
	}
	@Override
	public MomentorMemberVO passwordCheck(MomentorMemberVO vo){
		return sqlSessionTemplate.selectOne("member.passCheck", vo);
	}
	
	
	@Override
	public int idOverlappingCheck(String id) {
		return sqlSessionTemplate.selectOne("member.idOverlappingCheck", id);
	}
	@Override
	public int nickNameOverlappingCheck(String nickName) {
		return sqlSessionTemplate.selectOne("member.nickNameOverlappingCheck", nickName);
	}
	@Override
	public int emailOverlappingCheck(String memberEmail) {
		System.out.println("DAO "+memberEmail);
		return sqlSessionTemplate.selectOne("member.emailOverlappingCheck", memberEmail);
	}
	@Override
	public void registerMember(MomentorMemberVO vo) {
		sqlSessionTemplate.insert("member.registerMember", vo);
	}
	@Override
	public void registerPhysicalMember(MomentorMemberPhysicalVO pnvo) {
		sqlSessionTemplate.insert("member.registerPhysicalMember", pnvo);	
	}
	
	
	@Override
	public MomentorMemberPhysicalVO myPageMemberInfo(String memberId) {
		return sqlSessionTemplate.selectOne("member.myPageMemberInfo", memberId);	
	}
	@Override
	public MomentorMemberVO updateMember(MomentorMemberVO vo) {
		return sqlSessionTemplate.selectOne("member.myPageMemberInfoUpdate", vo);
	}
	@Override
	public MomentorMemberPhysicalVO updateMemberPhysical(MomentorMemberPhysicalVO pnvo) {
		return sqlSessionTemplate.selectOne("member.myPageMemberPhysicalInfoUpdate", pnvo);	
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
	public int myPasswordCheck(String password) {
		return sqlSessionTemplate.selectOne("member.myPasswordCheck", password);
	}
	@Override
	public List<BoardVO> getMyCommnunityBoardList(Map<String, String> map) {
		return sqlSessionTemplate.selectList("content.getMyCommnunityBoardList", map);
	}
	@Override
	public int countAllMyCommnunityBoard(String memberId) {
		return sqlSessionTemplate.selectOne("content.countAllMyCommnunityBoard", memberId);
	}
	@Override
	public List<ReplyVO> getMyReplyList(Map<String, String> map) {
		return sqlSessionTemplate.selectList("content.getMyReplyList", map);
	}
	@Override
	public int countAllMyReply(String memberId) {
		return sqlSessionTemplate.selectOne("content.countAllMyReply", memberId);
	}
	
	
	@Override
	public List<MomentorMemberPhysicalVO> managerGetAllMember(String PageNo) {
		return sqlSessionTemplate.selectList("member.managerGetAllMember", PageNo);
	}
	@Override
	public int totalMemberCount() {
		return sqlSessionTemplate.selectOne("member.totalMemberCount");
	}
	@Override
	public List<MomentorMemberPhysicalVO>  managerFindMemberById(HashMap<String, String> paramMap) {
		return sqlSessionTemplate.selectList("member.managerFindMemberById", paramMap);
	}
	@Override
	public int totalMemberFindByIdCount(String memberId) {
		return sqlSessionTemplate.selectOne("member.totalMemberFindByIdCount", memberId);
	}
	@Override
	public List<MomentorMemberPhysicalVO> managerFindMemberByName(HashMap<String, String> paramMap) {
		return sqlSessionTemplate.selectList("member.managerFindMemberByName", paramMap);
	}
	@Override
	public int totalMemberFindByNameCount(String memberName) {
		return sqlSessionTemplate.selectOne("member.totalMemberFindByNameCount", memberName);
	}
	@Override
	public List<MomentorMemberPhysicalVO>  managerFindMemberByNickName(HashMap<String, String> paramMap) {
		return sqlSessionTemplate.selectList("member.managerFindMemberByNickName", paramMap);
	}
	@Override
	public int totalMemberFindByNickNameCount(String nickName) {
		return sqlSessionTemplate.selectOne("member.totalMemberFindByNickNameCount", nickName);
	}
	@Override
	public int deleteMemberByAdmin(String id) {
		return sqlSessionTemplate.update("member.deleteMemberByAdmin", id);
	}
	
	
	@Override
	public MomentorMemberPhysicalVO getMemberInfoByNickName(String nickName) {
		return sqlSessionTemplate.selectOne("member.getMemberInfoByNickName", nickName);
	}
}