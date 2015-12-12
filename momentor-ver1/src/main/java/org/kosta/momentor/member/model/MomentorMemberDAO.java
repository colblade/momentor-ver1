package org.kosta.momentor.member.model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.kosta.momentor.contents.model.BoardVO;
import org.kosta.momentor.contents.model.ReplyVO;


public interface MomentorMemberDAO {
	public List<MomentorMemberPhysicalVO>  managerFindMemberById(HashMap<String,String> paramMap);//관리자가 회원정보 검색
	public List<MomentorMemberPhysicalVO>  managerFindMemberByNickName(HashMap<String,String> paramMap);//관리자가 회원정보 검색
	public List<MomentorMemberPhysicalVO> managerGetAllMember(String pageNo);//관리자가 모든 회원정보 검색
	public List<MomentorMemberPhysicalVO> managerFindMemberByName(HashMap<String,String> paramMap);//관리자가 이름으로 회원정보 검색
	public MomentorMemberPhysicalVO login(MomentorMemberVO vo); 		//로그인
	public MomentorMemberVO updateMember(MomentorMemberVO vo);		//수정
	public void registerMember(MomentorMemberVO vo) ;		//가입
	public void registerPhysicalMember(MomentorMemberPhysicalVO pnvo); //키 ,몸무게 , 나이
	public MomentorMemberVO idCheck(MomentorMemberVO vo);										//아이디 체크
	public MomentorMemberVO passwordCheck(MomentorMemberVO vo);		//패스워드 체크
	public MomentorMemberVO findMemberById(String name,String email);		//회원이 이름과 이메일로 아이디 찾기
	public MomentorMemberVO findMemberByPassword(String id, String name,String email);		//회원이 아이디, 이름, 이메일로 비밀번호 찾기	
	public double bmi(MomentorMemberPhysicalVO vo);			//신체 정보 키와 몸무게를 이용하여 bmi 계산
	public MomentorMemberPhysicalVO getMemberInfoByNickName(String nickName);//커뮤니티게시판에서 닉네임을 통해 회원정보 보기
	// bmi 공식 : 체중(kg) / 키(m) x 키(m)
	// 표준체중 공식 : 키(m) x 키(m) x bmi(여자는 21, 남자는 22)
	// 브로카법 표준체중 : 키(cm) - 100 x (여자는 0.85, 남자는 0.9)
	// bmi 공식 찾다 보니까 저런것도 나오길래 정보 공유겸 넣어 놓음
	public int deleteMemberByAdmin(String id); // 관리자가 회원아이디를 통해 회원강퇴
	public void deleteMemeber(MomentorMemberVO vo); // 회원탈퇴
	public int totalMemberContent();
	public int totalMemberFindByIdContent(String memberId);
	public int totalMemberFindByNameContent(String memberName);
	public int totalMemberFindByNickNameContent(String nickName);
	//mypage상 나의 글 보기
	public List<BoardVO> getMyCommnunityBoardList(Map<String, String> map);
	
	//mypage상 나의 답글 보기
	public List<ReplyVO> getMyReplyList(Map<String, String> map);
	
	public int idOverlappingCheck(String id) ;//아이디 중복체크
	public int nickNameOverlappingCheck(String nickName);//닉네임 중복체크
	public int emailOverlappingCheck(String memberEmail) ; //이메일 중복체크
	//mypage 내가 쓴 전체 글 수
	public int countAllMyCommnunityBoard(String memberId);
	//mypage 내가 쓴 전체 댓글 수
	public int countAllMyReply(String memberId);
	
	//마이페이지에서 패스워드 체크
			public int myPasswordCheck(String password) ;
			
					//수정
			public MomentorMemberPhysicalVO updateMemberPhysical(MomentorMemberPhysicalVO pnvo);

			// 회원탈퇴할때 아이디만 있어도 될꺼같아서 아이디만 가져옴
			public void myPageDeleteMemberInfo(String memberId); 
			public void myPageDeleteMemberPhysicalInfo(String memberId); 
			//회원이 마이페이지에서 내정보 조회 
			public MomentorMemberPhysicalVO myPageMemberInfo(String memberId);

}
