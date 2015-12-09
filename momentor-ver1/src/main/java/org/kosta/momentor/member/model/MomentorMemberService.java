package org.kosta.momentor.member.model;

import java.util.List;

import org.kosta.momentor.contents.model.BoardVO;
import org.kosta.momentor.contents.model.CommunityBoardVO;
import org.kosta.momentor.contents.model.ListVO;
import org.kosta.momentor.contents.model.ReListVO;
import org.kosta.momentor.contents.model.ReplyVO;

public interface MomentorMemberService {
	public MomentorMemberVO managerFindMemberById(String id);//관리자가 회원정보 검색
	public MomentorMemberVO managerFindMemberByNickName(String nickName);//관리자가 회원정보 검색
	public List<MomentorMemberVO> managerFindMemberByAddress(String address);//관리자가 회원정보 검색
	public List<MomentorMemberVO> managerFindMemberByName(String name);//관리자가 회원정보 검색
	public MomentorMemberPhysicalVO login(MomentorMemberVO vo);		//로그인
	public void updateMember(MomentorMemberVO vo);				//수정
	public void registerMember(MomentorMemberVO vo, String date, String memberEmail, String memberEmail2,String memberWeight,String memberHeight) ;			//가입
	public void registerPhysicalMember(MomentorMemberPhysicalVO pnvo); //키 ,몸무게 , 나이
	public MomentorMemberVO idCheck(MomentorMemberVO vo);										//아이디 체크
	public MomentorMemberVO passwordCheck(MomentorMemberVO vo);						//패스워드 체크
	public MomentorMemberVO findMemberById(String name,String email);		//회원이 이름과 이메일로 아이디 찾기
	public MomentorMemberVO findMemberByPassword(String id, String name,String email);		//회원이 아이디, 이름, 이메일로 비밀번호 찾기	
	public double bmi(MomentorMemberPhysicalVO vo);
	public MomentorMemberVO deleteMemberByAdmin(String id); // 관리자가 회원아이디를 통해 회원강퇴
	public void deleteMemeber(MomentorMemberVO vo); // 회원탈퇴


	public ListVO getMyCommnunityBoardList(String memberId,String pageNo);
	public ReListVO getMyReplyList(String memberId,String pageNo);


	public void SendEmail(EmailVO email) throws Exception; // email전송
	public String nickNameOverlappingCheck(String nickName);
	public String idOverlappingCheck(String idcheck);
	
	
	public String updateMember(MomentorMemberVO vo,MomentorMemberPhysicalVO pnvo) throws Exception; //회원이 자기정보 수정부분 vo와 pnvo를 같이 업데이트하기위해 추가
	public String myPasswordCheck(String password, String memberId) ;
	public String deleteMemeber(String memberId) throws Exception;	 //회원 탈퇴 하는데 id만 있으면 될꺼 같아서 이걸로 사용
	public MomentorMemberPhysicalVO myPageMemberInfo(String memberId); ////회원이 마이페이지에서 내정보 조회 
}
