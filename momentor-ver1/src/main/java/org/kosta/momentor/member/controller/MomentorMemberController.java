package org.kosta.momentor.member.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

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
	
	
	@RequestMapping("home.do")
	public ModelAndView home(){	
		 /** home은 view name
		 * tiles definition name으로 home이 있으면 tiles 적용 응답화면 제공
		 * 만약 없으면 viewResolver 우선 순위에 의해 일반 jsp로 응답*/	 
		ModelAndView mv = new ModelAndView("home");
	List<ExerciseBoardVO> ebList =	exerciseBoardService.getExerciseBoardListBestTop5ByHits();
	List<CommunityBoardVO> cbList =	communityBoardService.getCommunityBoardListBestTop5ByRecommend();
		mv.addObject("exerciseTop5List", ebList);
		mv.addObject("communityTop5List", cbList);
		return mv;
	}
	@RequestMapping("login_home.do")
	public ModelAndView loginHome(){
		ModelAndView mv = new ModelAndView("login_home");
		List<ExerciseBoardVO> ebList =	exerciseBoardService.getExerciseBoardListBestTop5ByHits();
		List<CommunityBoardVO> cbList =	communityBoardService.getCommunityBoardListBestTop5ByRecommend();
			mv.addObject("exerciseTop5List", ebList);
			mv.addObject("communityTop5List", cbList);
			return mv;
	}
	@RequestMapping(value = "login_login.do", method = RequestMethod.POST)
	public ModelAndView login(HttpServletRequest request, MomentorMemberVO vo) {
		String path = "login_fail";
		MomentorMemberPhysicalVO rvo = momentorMemberService.login(vo);
		System.out.println(rvo);
		if (rvo != null) {
			request.getSession().setAttribute("pnvo", rvo);
			path = "login_ok";
		}
		return new ModelAndView(path);
	}	
	@RequestMapping("logout.do")
	public String logout(HttpServletRequest request) {
		HttpSession session = request.getSession(false);
		if (session != null)
			session.invalidate();
		return "redirect:home.do";
	}
	@RequestMapping("member_register.do")
	public String registerView(){
		return "member_register";
	}
	@RequestMapping("register_result.do")
	public ModelAndView register(HttpServletRequest request,String date, String memberEmail,String memberEmail2,MomentorMemberVO vo,String memberWeight,String memberHeight){
         HttpSession session=request.getSession();
         momentorMemberService.registerMember(vo, date, memberEmail, memberEmail2,memberWeight,memberHeight);
         MomentorMemberPhysicalVO pnvo = momentorMemberService.login(vo);
         session.setAttribute("pnvo", pnvo);
         return new ModelAndView("redirect:registerOk.do","pnvo",pnvo);   
    }
	 
	@RequestMapping("registerOk.do")
	public String registerOk(){
		return "my_registerOk";
	}
	 
	@RequestMapping("check_idCheck.do")
	@ResponseBody
	public MomentorMemberVO idCheck(HttpServletRequest request,MomentorMemberVO vo){
		MomentorMemberVO mvo = momentorMemberService.idCheck(vo);
		return mvo;
	}
	@Autowired
	private EmailVO email;
	@RequestMapping("check_passCheck.do")
	@ResponseBody
	public MomentorMemberVO passwordCheck(MomentorMemberVO vo) throws Exception{		
        MomentorMemberVO mvo = momentorMemberService.passwordCheck(vo);
        String id = mvo.getMemberId();
        String e_mail = mvo.getMemberEmail();
        String pass = mvo.getMemberPassword();
        if(pass != null) {
            email.setContent("비밀번호는 "+pass+" 입니다.");
            email.setReceiver(e_mail);
            email.setSubject(id+"님 비밀번호 찾기 메일입니다.");
			momentorMemberService.SendEmail(email);
        }	
		return mvo;
	}
	@RequestMapping("my_getPlannerList.do")
	@ResponseBody
	public ArrayList<PlannerVO> getPlannerList(PlannerVO pvo){
		ArrayList<PlannerVO> list = (ArrayList<PlannerVO>) plannerService.getPlannerList(pvo);
		return list;
	}
	@RequestMapping("my_planner.do")
	public ModelAndView planner(HttpServletRequest request){
		return new ModelAndView("my_planner", "plannerDate", request.getParameter("plannerDate"));
	}

	@RequestMapping("my_registerInPlanner.do")
	@ResponseBody
	public void registerExerciseInPlanner(PlannerVO pvo){
		plannerService.registerExerciseInPlanner(pvo);
	}
	
	@RequestMapping("my_getPlannerListByDate.do")
	@ResponseBody
	public ArrayList<PlannerVO> getPlannerListByDate(PlannerVO pvo){
		ArrayList<PlannerVO> list = (ArrayList<PlannerVO>) plannerService.getPlannerListByDate(pvo);
		return list;
	}
	
	@RequestMapping("my_getCartList.do")
	@ResponseBody
	public ArrayList<CartVO> getCartList(String id){
		ArrayList<CartVO> list = (ArrayList<CartVO>) plannerService.getCartList(id);
		//System.out.println(list);
		return list;
	}
	
	@RequestMapping("my_deleteExcerciseInCart.do")
	@ResponseBody
	public void deleteExcerciseInCart(CartVO cvo){
		plannerService.deleteExcerciseInCart(cvo);
	}
	
	@RequestMapping("my_deleteExerciseInPlanner.do")
	@ResponseBody
	public void deleteExerciseInPlanner(HttpServletRequest request, PlannerVO pvo){
		String[] deleteArray = request.getParameterValues("exerciseVO.exerciseName");
		for(int i=0; i<deleteArray.length; i++){
			pvo.setExerciseVO(new ExerciseVO(deleteArray[i], null));
			plannerService.deleteExerciseInPlanner(pvo);
		}
	}
	
	@RequestMapping("my_getPlannerContentByDate.do")
	@ResponseBody
	public String getPlannerContentByDate(PlannerVO pvo) throws UnsupportedEncodingException {
		// controller 에서  jquery ajax 로 보낼때 인코딩 처리
		return URLEncoder.encode(plannerService.getPlannerContentByDate(pvo), "UTF-8");
	}
	
	@RequestMapping("my_updateAchievementInPlanner.do")
	@ResponseBody
	public void updateAchievementInPlanner(PlannerVO pvo){
		plannerService.updateAchievementInPlanner(pvo);
	}
	
	@RequestMapping("my_updateCommentInPlanner.do")
	@ResponseBody
	public void updateCommentInPlanner(PlannerVO pvo){
		int updateResult = plannerService.updateCommentInPlanner(pvo);
		if(updateResult == 0){ // 업데이트할 코멘트가 없으면(실행결과가 0이면) 등록
			plannerService.registerCommentInPlanner(pvo);
		}
	}

	
	@RequestMapping("my_myPage.do")
	public String myPage(){
		/*	MomentorMemberPhysicalVO pnvo = (MomentorMemberPhysicalVO) request.getSession().getAttribute("pnvo");
		return new ModelAndView("my_mypage","pnvo",pnvo);		*/
		return "my_mypage";
	}
	
	@RequestMapping("my_getMyCommnunityBoardList")
	public ModelAndView getMyCommnunityBoardList(String memberId,String pageNo){
		ModelAndView mv = new ModelAndView("my_myboard_result");
		ListVO lvo = momentorMemberService.getMyCommnunityBoardList(memberId,pageNo);
		ArrayList<CommunityBoardVO> list = (ArrayList)lvo.getList();
		PagingBean pb = lvo.getPagingBean();
		mv.addObject("boardList", list);
		mv.addObject("pageObject", pb);
		
		return mv;
	}
	
	
	@RequestMapping("my_getMyReplyList")
	public ModelAndView getMyReplyList(String memberId,String pageNo){
		ModelAndView mv = new ModelAndView("my_myreply_result");
		ReListVO rvo = momentorMemberService.getMyReplyList(memberId,pageNo);
		ArrayList<ReplyVO> list = (ArrayList)rvo.getList();
		PagingBean pb = rvo.getPagingBean();
		mv.addObject("replyList", list);
		mv.addObject("pageObject", pb);
		
		return mv;
	}

	@RequestMapping("nickNameCheck.do")
	@ResponseBody
	public String nickNameCheckAjax(String nickName) {
		return momentorMemberService.nickNameOverlappingCheck(nickName);
	}

	@RequestMapping("idcheck.do")
	@ResponseBody
	public String idcheckAjax(String idcheck) {
		return momentorMemberService.idOverlappingCheck(idcheck);
	}

	@RequestMapping("my_myInfo.do")
	public ModelAndView myInfo(HttpServletRequest request) {
		MomentorMemberPhysicalVO pnvo = (MomentorMemberPhysicalVO) request.getSession().getAttribute("pnvo");
		momentorMemberService.myPageMemberInfo(pnvo.getMomentorMemberVO().getMemberId());
		return new ModelAndView("my_myInfo", "pnvo", pnvo);
	}
}