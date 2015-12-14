package org.kosta.momentor.member.model;

import org.kosta.momentor.contents.model.ListVO;
import org.kosta.momentor.contents.model.ReListVO;

public interface MomentorMemberService {
	public MomentorMemberPhysicalVO login(MomentorMemberVO vo); // 로그인
	public MomentorMemberVO idCheck(MomentorMemberVO vo); // 아이디 찾기
	public MomentorMemberVO passwordCheck(MomentorMemberVO vo); // 비밀번호 찾기
	public void SendEmail(EmailVO email) throws Exception; // 비밀번호 찾기 email전송
	
	public String idOverlappingCheck(String idcheck); // 회원가입시 아이디 중복 검사
	public String nickNameOverlappingCheck(String nickName); // 회원가입시 닉네임 중복 검사
	public String emailOverlappingCheck(String memberEmail,String memberEmail2); // 회원가입시 이메일 중복검사
	public void registerMember(MomentorMemberVO vo, String date, String memberEmail, String memberEmail2,String memberWeight,String memberHeight); // 회원가입

	public MomentorMemberPhysicalVO myPageMemberInfo(String memberId); // 마이페이지에서 본인 회원정보 보기 
	public String updateMember(String myBirthDate, MomentorMemberVO vo, MomentorMemberPhysicalVO pnvo) throws Exception; // 회원정보 수정(vo와 pnvo를 같이 업데이트하기위해 추가)
	public String deleteMemeber(String memberId) throws Exception; //회원 탈퇴
	public String myPasswordCheck(String password, String memberId); // 회원정보 수정/탈퇴 시 패스워드 체크
	public ListVO getMyCommnunityBoardList(String memberId,String pageNo); // 내가 쓴 커뮤니티 게시글 리스트
	public ReListVO getMyReplyList(String memberId,String pageNo); // 내가 쓴 댓글 리스트
	
	public MemberListVO managerGetAllMember(String pageNo); // 관리자가 회원 목록 보기
	public MemberListVO managerFindMemberById(String memberId,String pageNo); // 관리자가 아이디로 회원 검색
	public MemberListVO managerFindMemberByName(String name,String pageNo); // 관리자가 이름으로 회원 검색
	public MemberListVO managerFindMemberByNickName(String nickName,String pageNo); // 관리자가 닉네임으로 회원 검색
	public int deleteMemberByAdmin(String id); // 관리자가 회원 강퇴
	
	public MomentorMemberPhysicalVO getMemberInfoByNickName(String nickName); // 커뮤니티게시판에서 닉네임으로 회원정보 보기
}