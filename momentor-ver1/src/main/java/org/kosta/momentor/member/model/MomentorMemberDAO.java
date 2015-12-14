package org.kosta.momentor.member.model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.kosta.momentor.contents.model.BoardVO;
import org.kosta.momentor.contents.model.ReplyVO;


public interface MomentorMemberDAO {
	public MomentorMemberPhysicalVO login(MomentorMemberVO vo); // 로그인
	public MomentorMemberVO idCheck(MomentorMemberVO vo); // 아이디 찾기
	public MomentorMemberVO passwordCheck(MomentorMemberVO vo); // 비밀번호 찾기

	public int idOverlappingCheck(String id); // 회원가입시 아이디 중복 검사
	public int nickNameOverlappingCheck(String nickName); // 회원가입시 닉네임 중복 검사
	public int emailOverlappingCheck(String memberEmail); // 회원가입시 이메일 중복검사
	public void registerMember(MomentorMemberVO vo); // 회원가입
	public void registerPhysicalMember(MomentorMemberPhysicalVO pnvo); //회원가입시 신체정보 등록
	// bmi 공식 : 체중(kg) / 키(m) x 키(m)
	// 표준체중 공식 : 키(m) x 키(m) x bmi(여자는 21, 남자는 22)
	// 브로카법 표준체중 : 키(cm) - 100 x (여자는 0.85, 남자는 0.9)
	// bmi 공식 찾다 보니까 저런것도 나오길래 정보 공유겸 넣어 놓음

	public MomentorMemberPhysicalVO myPageMemberInfo(String memberId); // 마이페이지에서 본인 회원정보 보기
	public MomentorMemberVO updateMember(MomentorMemberVO vo); // 회원정보 수정
	public MomentorMemberPhysicalVO updateMemberPhysical(MomentorMemberPhysicalVO pnvo); //회원 신체정보 수정
	public void myPageDeleteMemberInfo(String memberId); //회원 탈퇴시 일반정보 변경(auth)
	public void myPageDeleteMemberPhysicalInfo(String memberId); //회원 탈퇴시 신체정보 삭제
	public int myPasswordCheck(String password); // 회원정보 수정/탈퇴 시 패스워드 체크
	public List<BoardVO> getMyCommnunityBoardList(Map<String, String> map); // 내가 쓴 커뮤니티 게시글 리스트
	public int countAllMyCommnunityBoard(String memberId); // 내가 쓴 전체 글 수
	public List<ReplyVO> getMyReplyList(Map<String, String> map); // 내가 쓴 댓글 리스트
	public int countAllMyReply(String memberId); // 내가 쓴 전체 댓글 수
	
	public List<MomentorMemberPhysicalVO> managerGetAllMember(String pageNo); // 관리자가 회원 목록 보기
	public int totalMemberCount(); // 전체 회원 수
	public List<MomentorMemberPhysicalVO> managerFindMemberById(HashMap<String,String> paramMap); // 관리자가 아이디로 회원 검색
	public int totalMemberFindByIdCount(String memberId); // 아이디로 해당 검색어를 포함하고있는 전체 회원 수
	public List<MomentorMemberPhysicalVO> managerFindMemberByName(HashMap<String,String> paramMap); // 관리자가 이름으로 회원 검색
	public int totalMemberFindByNameCount(String memberName); // 이름으로 해당 검색어를 포함하고있는 전체 회원 수
	public List<MomentorMemberPhysicalVO> managerFindMemberByNickName(HashMap<String,String> paramMap);; // 관리자가 닉네임으로 회원 검색
	public int totalMemberFindByNickNameCount(String nickName); // 닉네임으로 해당 검색어를 포함하고있는 전체 회원 수
	public int deleteMemberByAdmin(String id); // 관리자가 회원 강퇴

	public MomentorMemberPhysicalVO getMemberInfoByNickName(String nickName); // 커뮤니티게시판에서 닉네임으로 회원정보 보기
}