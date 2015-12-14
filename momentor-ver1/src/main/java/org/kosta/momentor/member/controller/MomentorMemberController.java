package org.kosta.momentor.member.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;










import java.util.Map;




//github.com/colblade/Momentor-test.git
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.kosta.momentor.cart.model.CartVO;
import org.kosta.momentor.cart.model.ExerciseVO;
import org.kosta.momentor.contents.model.CommunityBoardService;
import org.kosta.momentor.contents.model.CommunityBoardVO;
import org.kosta.momentor.contents.model.ExerciseBoardService;
import org.kosta.momentor.contents.model.ExerciseBoardVO;
import org.kosta.momentor.contents.model.ListVO;
import org.kosta.momentor.contents.model.PagingBean;
import org.kosta.momentor.contents.model.ReListVO;
import org.kosta.momentor.contents.model.ReplyVO;
//github.com/colblade/Momentor-test.git
import org.kosta.momentor.member.model.EmailVO;
import org.kosta.momentor.member.model.MomentorMemberPhysicalVO;
import org.kosta.momentor.member.model.MomentorMemberService;
import org.kosta.momentor.member.model.MomentorMemberVO;
import org.kosta.momentor.planner.model.PlannerService;
import org.kosta.momentor.planner.model.PlannerVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class MomentorMemberController {
	@Resource
	private MomentorMemberService momentorMemberService;
	@Resource
	private PlannerService plannerService;
	@Resource
	private ExerciseBoardService exerciseBoardService;
	@Resource
	private CommunityBoardService communityBoardService;
	
	// 비로그인시 홈
	@RequestMapping("home.do")
	public ModelAndView home(){	
		/** home은 view name
		 * tiles definition name으로 home이 있으면 tiles 적용 응답화면 제공
		 * 만약 없으면 viewResolver 우선 순위에 의해 일반 jsp로 응답*/	 
		ModelAndView mv = new ModelAndView();
		List<ExerciseBoardVO> ebList =	exerciseBoardService.getExerciseBoardListBestTop5ByHits();
		List<CommunityBoardVO> cbList =	communityBoardService.getCommunityBoardListBestTop5ByRecommend();
		mv.addObject("exerciseTop5List", ebList);
		mv.addObject("communityTop5List", cbList);
		mv.setViewName("home");
		return mv;
	}
	// 로그인시 홈
	@RequestMapping("login_home.do")
	public ModelAndView loginHome(){
		ModelAndView mv = new ModelAndView();
		List<ExerciseBoardVO> ebList =	exerciseBoardService.getExerciseBoardListBestTop5ByHits();
		List<CommunityBoardVO> cbList =	communityBoardService.getCommunityBoardListBestTop5ByRecommend();
		mv.addObject("exerciseTop5List", ebList);
		mv.addObject("communityTop5List", cbList);
		mv.setViewName("login_home");
		return mv;
	}
	// 로그인
	@RequestMapping(value = "login_login.do", method = RequestMethod.POST)
	   public ModelAndView login(HttpServletRequest request, MomentorMemberVO vo) {
		String path = "login_fail";
		MomentorMemberPhysicalVO pnvo = momentorMemberService.login(vo);
		if (pnvo != null) {
			request.getSession().setAttribute("pnvo", pnvo);
			int auth=pnvo.getMomentorMemberVO().getAuth();
			if(auth==2){
				path = "login_ok";
			}else if(auth==1){
				path="admin_login_ok";
			}
		}
		return new ModelAndView(path);
	}
	// 로그아웃
	@RequestMapping("logout.do")
	public String logout(HttpServletRequest request) {
		HttpSession session = request.getSession(false);
		if (session != null)
			session.invalidate();
		return "redirect:home.do";
	}
	
	
	// 아이디 찾기
	@RequestMapping("check_idCheck.do")
	@ResponseBody
	public MomentorMemberVO idCheck(MomentorMemberVO vo){
		MomentorMemberVO mvo = momentorMemberService.idCheck(vo);
		return mvo;
	}
	// 비밀번호 찾기
	@Autowired
	private EmailVO email;
	@RequestMapping("check_passCheck.do")
	@ResponseBody
	public MomentorMemberVO passwordCheck(MomentorMemberVO vo) throws Exception{      
		MomentorMemberVO mvo = momentorMemberService.passwordCheck(vo);
		if(mvo != null){
			String id = mvo.getMemberId();
			String e_mail = mvo.getMemberEmail();
			String pass = mvo.getMemberPassword();
			if(pass != null) {
				email.setSubject(id+"님 비밀번호 찾기 메일입니다.");
				email.setContent("비밀번호는 "+pass+" 입니다.");
				email.setReceiver(e_mail);
				momentorMemberService.SendEmail(email);
			}
		}
		return mvo;
	}
	
	
	// 회원가입시 아이디 중복 검사
	@RequestMapping("idcheck.do")
	@ResponseBody
	public String idcheckAjax(String idcheck) {
		return momentorMemberService.idOverlappingCheck(idcheck);
	}
	// 회원가입시 닉네임 중복 검사
	@RequestMapping("nickNameCheck.do")
	@ResponseBody
	public String nickNameCheckAjax(String nickName) {
		return momentorMemberService.nickNameOverlappingCheck(nickName);
	}
	// 회원가입시 이메일 중복검사
	@RequestMapping("emailcheck.do")
	@ResponseBody
	public String emailcheckAjax(String memberEmail1, String memberEmail2) {
		return momentorMemberService.emailOverlappingCheck(memberEmail1, memberEmail2);
	}
	// 회원가입(후 자동 로그인)
	@RequestMapping("register_result.do")
	@ResponseBody
	public ModelAndView register(HttpServletRequest request, String date, String memberEmail1, String memberEmail2, MomentorMemberVO vo, String memberWeight, String memberHeight){
		HttpSession session=request.getSession();
		momentorMemberService.registerMember(vo, date, memberEmail1, memberEmail2, memberWeight, memberHeight);
		MomentorMemberPhysicalVO pnvo = momentorMemberService.login(vo);
		session.setAttribute("pnvo", pnvo);
		return new ModelAndView("redirect:registerOk.do", "pnvo", pnvo);
    }
	// 회원가입 결과
	@RequestMapping("registerOk.do")
	public String registerOk(){
		return "my_registerOk";
	}
	
	
	// 일반회원 마이페이지
	@RequestMapping("my_myPage.do")
	public String myPage(){
		return "my_mypage";
	}
	// 마이페이지에서 본인 회원정보 보기
	@RequestMapping("my_myInfo.do")
	public ModelAndView myInfo(HttpServletRequest request) {
		MomentorMemberPhysicalVO pnvo = (MomentorMemberPhysicalVO) request.getSession().getAttribute("pnvo");
		momentorMemberService.myPageMemberInfo(pnvo.getMomentorMemberVO().getMemberId());
		return new ModelAndView("my_myInfo", "pnvo", pnvo);
	}
	// 회원정보 수정 페이지
	@RequestMapping("my_myInfoUpdateForm.do")
	public ModelAndView memberInfoUpdateForm(String memberId){
		MomentorMemberPhysicalVO pnvo = momentorMemberService.myPageMemberInfo(memberId);
		return new ModelAndView("my_myInfoUpdateForm", "pnvo", pnvo);
	}
	/**
	 * 뷰에서 값을 받아와 실제 업데이트 하는 메소드
	 * @throws Exception 
	 */
	// 회원정보 수정
	@RequestMapping("my_myInfoUpdate.do")
	public ModelAndView myPageMemberInfoUpdate(HttpServletRequest request, String myBirthDate, MomentorMemberVO mvo, MomentorMemberPhysicalVO pnvo) throws Exception{
		pnvo.setMomentorMemberVO(mvo);
		MomentorMemberPhysicalVO mpvo = pnvo;
		mpvo.setMomentorMemberVO(mvo);
		request.getSession().setAttribute("pnvo", pnvo);
		momentorMemberService.updateMember(myBirthDate, mvo, mpvo);
		return new ModelAndView("my_myInfoUpdate", "pnvo", pnvo);
	}
	// 회원 탈퇴 페이지
	@RequestMapping("my_myInfoDeleteForm.do")
	public ModelAndView myInfoDeleteForm(String memberId){
		MomentorMemberPhysicalVO pnvo = momentorMemberService.myPageMemberInfo(memberId);
		return new ModelAndView("my_myInfoDeleteForm", "pnvo", pnvo);
	}
	// 회원 탈퇴
	@RequestMapping("my_myInfoDelete.do")
	public ModelAndView myInfoDelete(HttpServletRequest request, MomentorMemberPhysicalVO pnvo) throws Exception{
		String deleteReason = request.getParameter("DeleteReason");
		String memberId = request.getParameter("id");
		momentorMemberService.deleteMemeber(memberId);
		HttpSession session = request.getSession(false);
		if(session != null){
			session.invalidate();
		}
		return new ModelAndView("my_myInfoDelete", "deleteReason", deleteReason);
	}
	// 회원정보 수정/탈퇴 시 패스워드 체크
	@RequestMapping("my_passwordCheck.do")
	@ResponseBody
	public String myPasswordCheck(HttpServletRequest request, String memberPasswordCheck) {
		String memberId = request.getParameter("id");
		return momentorMemberService.myPasswordCheck(memberPasswordCheck, memberId);
	}
	// 내가 쓴 커뮤니티 게시글 리스트
	@RequestMapping("my_getMyCommnunityBoardList")
	public ModelAndView getMyCommnunityBoardList(String memberId, String pageNo){
		ModelAndView mv = new ModelAndView();
		ListVO lvo = momentorMemberService.getMyCommnunityBoardList(memberId, pageNo);
		ArrayList<CommunityBoardVO> list = (ArrayList)lvo.getList();
		PagingBean pb = lvo.getPagingBean();
		mv.addObject("boardList", list);
		mv.addObject("pageObject", pb);
		mv.setViewName("my_myboard_result");
		return mv;
	}
	// 내가 쓴 리플 리스트
	@RequestMapping("my_getMyReplyList")
	public ModelAndView getMyReplyList(String memberId, String pageNo){
		ModelAndView mv = new ModelAndView();
		ReListVO rvo = momentorMemberService.getMyReplyList(memberId, pageNo);
		ArrayList<ReplyVO> list = (ArrayList)rvo.getList();
		PagingBean pb = rvo.getPagingBean();
		mv.addObject("replyList", list);
		mv.addObject("pageObject", pb);
		mv.setViewName("my_myreply_result");
		return mv;
	}
	
	
	// 관리자 마이페이지
	@RequestMapping("admin_myPage.do")
	public String adminMyPage(){
		return "admin_my_mypage";
	}
	// 관리자가 회원 목록 보기
	@RequestMapping("admin_my_meberList.do")
	public ModelAndView adminMypage(String pageNo){
		return  new ModelAndView("admin_my_memberList", "list", momentorMemberService.managerGetAllMember(pageNo));
	}
	// 관리자가 회원 검색(아이디, 이름, 닉네임)
	@RequestMapping("admin_my_managerFindBy.do")
	public ModelAndView managerFindById(String search,String pageNo,String searchMenu){
		ModelAndView mv=new ModelAndView();
		if(searchMenu.equals("id")){
			mv.addObject("list", momentorMemberService.managerFindMemberById(search, pageNo));
		}if(searchMenu.equals("name")){
			mv.addObject("list", momentorMemberService.managerFindMemberByName(search, pageNo));
		}if(searchMenu.equals("nickName")){
			mv.addObject("list", momentorMemberService.managerFindMemberByNickName(search, pageNo));
		}
		mv.addObject("searchMenu",searchMenu);
		mv.addObject("search", search);
		mv.setViewName("admin_my_find_member_result");
		return mv;
	}
	// 관리자가 회원 강퇴
	@RequestMapping("deleteMemberByAdmin.do")
	public ModelAndView deleteMemberByAdmin(String memberId,String pageNo,String searchMenu,String search){
		momentorMemberService.deleteMemberByAdmin(memberId);
		ModelAndView mv=new ModelAndView("admin_my_memberList", "list", momentorMemberService.managerGetAllMember(pageNo));
		if(searchMenu!=null&&search!=null){
			if(searchMenu.equals("id")){
				mv.addObject("list", momentorMemberService.managerFindMemberById(search, pageNo));
			}else if(searchMenu.equals("name")){
				mv.addObject("list", momentorMemberService.managerFindMemberByName(search, pageNo));
			}else if(searchMenu.equals("nickName")){
				mv.addObject("list", momentorMemberService.managerFindMemberByNickName(search, pageNo));
			}
			mv.addObject("searchMenu",searchMenu);
			mv.addObject("search", search);
			mv.setViewName("admin_my_find_member_result");
		}
		return mv;
	}
	
	
	// 커뮤니티게시판에서 닉네임으로 회원정보 보기
	@RequestMapping("getMemberInfoByNickName.do")
	@ResponseBody
	public MomentorMemberPhysicalVO getMemberInfoByNickName(HttpServletRequest request){
		String nickName = request.getParameter("momentorMemberVO.nickName");
		return momentorMemberService.getMemberInfoByNickName(nickName);
	}

	
	// 홈에서 해당회원의 각 날짜별 플래너 리스트 출력
	@RequestMapping("my_getPlannerList.do")
	@ResponseBody
	public ArrayList<PlannerVO> getPlannerList(HttpServletRequest request){
		String memberId = request.getParameter("momentorMemberVO.memberId");
		ArrayList<PlannerVO> list = (ArrayList<PlannerVO>) plannerService.getPlannerList(memberId);
		return list;
	}
	// 해당일 플래너 접근(찜바구니 리스트, 해당일 운동 리스트 출력)
	@RequestMapping("my_planner.do")
	public ModelAndView planner(PlannerVO pvo){
		ModelAndView mv = new ModelAndView();
		// Date 클래스를 통해 오늘의 년월일을 yyyy-MM-dd 형으로 추출
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String today = sdf.format(date);
		ArrayList<CartVO> cartList = (ArrayList<CartVO>) plannerService.getCartList(pvo.getMomentorMemberVO().getMemberId());
		ArrayList<PlannerVO> plannerListByDate = (ArrayList<PlannerVO>) plannerService.getPlannerListByDate(pvo);
		int intTypeSelectDate = Integer.parseInt(pvo.getPlannerDate().replaceAll("-", "")); // 날짜 비교를 위해 선택한 날을 int 타입으로 변환
		int intTypeToday = Integer.parseInt(today.replaceAll("-", "")); // 날짜 비교를 위해 오늘을 int 타입으로 변환
		mv.addObject("intTypeSelectDate", intTypeSelectDate);
		mv.addObject("intTypeToday", intTypeToday);
		ArrayList<HashMap<String, Object>> imgCartList = new ArrayList<HashMap<String, Object>>();
		for(int i=0; i<cartList.size(); i++){
			String exerciseName = cartList.get(i).getExerciseBoardVO().getExerciseVO().getExerciseName();
			List<Map<String, String>> map = (ArrayList)exerciseBoardService.getFileListByExerciseName(exerciseName);
			if(map != null){
				HashMap<String, Object> paramMap = new HashMap<String, Object>();
				paramMap.put(exerciseName, map);
				imgCartList.add(paramMap);
			}else{
				HashMap<String, Object> paramMap = new HashMap<String, Object>();
				paramMap.put(exerciseName, null);
				imgCartList.add(paramMap);
			}
		}
		mv.addObject("today", today);
		mv.addObject("selectDate", pvo.getPlannerDate());
		mv.addObject("cartList", cartList);
		mv.addObject("plannerListByDate", plannerListByDate);
		mv.addObject("imgCartList", imgCartList);
		mv.setViewName("my_planner");
		return mv;
	}
	// 플래너에서 운동명 클릭시 해당운동 상세정보 출력
	@RequestMapping("my_getExerciseInfoByExName.do")
	@ResponseBody
	public Map<String, Object> getExerciseInfoByExName(HttpServletRequest request){
		Map<String, Object> map = exerciseBoardService.getExerciseInfoByExName(request.getParameter("exerciseVO.exerciseName"));
		return map;
	}
	// 해당일의 플래너에 등록된 운동 리스트 출력
	@RequestMapping("my_getPlannerListByDate.do")
	@ResponseBody
	public ArrayList<PlannerVO> getPlannerListByDate(PlannerVO pvo){
		ArrayList<PlannerVO> list = (ArrayList<PlannerVO>) plannerService.getPlannerListByDate(pvo);
		return list; 
	}
	// 플래너에 운동 등록
	@RequestMapping("my_registerInPlanner.do")
	@ResponseBody
	public ArrayList<PlannerVO> registerExerciseInPlanner(PlannerVO pvo){
		plannerService.registerExerciseInPlanner(pvo);
		return (ArrayList<PlannerVO>) plannerService.getPlannerListByDate(pvo);
	}
	// 플래너에서 운동 삭제
	@RequestMapping("my_deleteExerciseInPlanner.do")
	@ResponseBody
	public ArrayList<PlannerVO> deleteExerciseInPlanner(HttpServletRequest request, PlannerVO pvo){
		String[] deleteArray = request.getParameterValues("exerciseVO.exerciseName");
		for(int i=0; i<deleteArray.length; i++){
			pvo.setExerciseVO(new ExerciseVO(deleteArray[i], null));
			plannerService.deleteExerciseInPlanner(pvo);
		}
		return (ArrayList<PlannerVO>) plannerService.getPlannerListByDate(pvo);
	}
	// 플래너에서 달성도 등록
	@RequestMapping("my_updateAchievementInPlanner.do")
	@ResponseBody
	public ArrayList<PlannerVO> updateAchievementInPlanner(PlannerVO pvo){
		plannerService.updateAchievementInPlanner(pvo);
		return (ArrayList<PlannerVO>) plannerService.getPlannerListByDate(pvo);
	}
	// 플래너의 목표세트 수정
	@RequestMapping("my_updateTargetSetInPlanner.do")
	@ResponseBody
	public ArrayList<PlannerVO> updateTargetSetInPlanner(PlannerVO pvo){
		plannerService.updateTargetSetInPlanner(pvo);
		return (ArrayList<PlannerVO>) plannerService.getPlannerListByDate(pvo);
	}
	// 해당일의 플래너 코멘트 불러오기
	@RequestMapping("my_getPlannerContentByDate.do")
	@ResponseBody
	public String getPlannerContentByDate(PlannerVO pvo) throws UnsupportedEncodingException {
		// controller 에서  jquery ajax 로 보낼때 인코딩 처리
		return URLEncoder.encode(plannerService.getPlannerContentByDate(pvo), "UTF-8");
	}
	// 해당일의 플래너에 코멘트 수정/등록
	@RequestMapping("my_updateCommentInPlanner.do")
	@ResponseBody
	public void updateCommentInPlanner(PlannerVO pvo){
		int updateResult = plannerService.updateCommentInPlanner(pvo);
		if(updateResult == 0){ // 업데이트할 코멘트가 없으면(실행결과가 0이면) 등록
			plannerService.registerCommentInPlanner(pvo);
		}
	}
	// 찜바구니 리스트 출력
	@RequestMapping("my_getCartList.do")
	@ResponseBody
	public ArrayList<CartVO> getCartList(HttpServletRequest request){
		String memberId = request.getParameter("momentorMemberVO.memberId");
		return (ArrayList<CartVO>) plannerService.getCartList(memberId);
	}
	// 찜바구니에 운동 담기
	@RequestMapping("my_registerExerciseInCart.do")
	@ResponseBody
	public ArrayList<CartVO> registerExerciseInCart(CartVO cvo){
		plannerService.registerExerciseInCart(cvo);
		return (ArrayList<CartVO>) plannerService.getCartList(cvo.getMomentorMemberVO().getMemberId());
	}
	// 찜바구니에서 운동 삭제
	@RequestMapping("my_deleteExcerciseInCart.do")
	@ResponseBody
	public Map<String, Object> deleteExcerciseInCart(CartVO cvo){
		plannerService.deleteExcerciseInCart(cvo);
		Map<String, Object> deleteMap = new HashMap<String, Object>();
		ArrayList<CartVO> cartList = (ArrayList<CartVO>) plannerService.getCartList(cvo.getMomentorMemberVO().getMemberId());
		ArrayList<HashMap<String, Object>> imgCartList = new ArrayList<HashMap<String, Object>>();
		for(int i=0; i<cartList.size(); i++){
			String exerciseName = cartList.get(i).getExerciseBoardVO().getExerciseVO().getExerciseName();
			List<Map<String, String>> fileListMap = (ArrayList)exerciseBoardService.getFileListByExerciseName(exerciseName);
			HashMap<String, Object> paramMap = new HashMap<String, Object>();
			if(fileListMap != null){
				paramMap.put(exerciseName, fileListMap);
				imgCartList.add(paramMap);
			}else{
				paramMap.put(exerciseName, null);
				imgCartList.add(paramMap);
			}
		}
		deleteMap.put("cartList", cartList);
		deleteMap.put("imgCartList", imgCartList);
		return deleteMap;
	}
}
