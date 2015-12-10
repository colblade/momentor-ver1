package org.kosta.momentor.contents.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.kosta.momentor.cart.model.ExerciseVO;
import org.kosta.momentor.contents.model.BoardVO;
import org.kosta.momentor.contents.model.CommunityBoardService;
import org.kosta.momentor.contents.model.CommunityBoardVO;
import org.kosta.momentor.contents.model.ExerciseBoardService;
import org.kosta.momentor.contents.model.ExerciseBoardVO;
import org.kosta.momentor.contents.model.FileVO;
import org.kosta.momentor.contents.model.ListVO;
import org.kosta.momentor.contents.model.NoticeBoardService;
import org.kosta.momentor.contents.model.NoticeBoardVO;
import org.kosta.momentor.contents.model.PagingBean;
import org.kosta.momentor.contents.model.ReplyVO;
import org.kosta.momentor.member.model.MomentorMemberPhysicalVO;
import org.kosta.momentor.member.model.MomentorMemberVO;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
@Controller
public class ContentsController {
	@Resource
	private NoticeBoardService noticeBoardService;
	@Resource
	private ExerciseBoardService exerciseBoardService;
	@Resource
	private CommunityBoardService communityBoardService;
	/* 커뮤니티 게시판 글쓰기 등록*/ 
	   @RequestMapping(value="my_postingCommunity.do",method=RequestMethod.POST)
	   public ModelAndView postingCommunity(CommunityBoardVO cvo){
	      communityBoardService.postingCommunity(cvo);
	      ModelAndView mv=new ModelAndView();
	      mv.setViewName("redirect:/member_ getCommunityNoHitByNo.do");
	      mv.addObject("boardNo",cvo.getBoardNo());
	      return mv;
	   }
	   /*커뮤니티 게시판 게시글 보여주기*/
	   @RequestMapping("showCommunityList.do")
	   public ModelAndView showCommunityList(String pageNo){
	      return new ModelAndView("member_showCommunityList","list",communityBoardService.getAllPostingList(pageNo));
	      
	   }
	 
	/*커뮤니티 게시판 글쓰기 폼으로 이동*/
	@RequestMapping("my_writeForm.do")
	public ModelAndView writeForm(HttpServletRequest request){
		return new ModelAndView("my_postingCommunity");
	}

	   /*커뮤니티 게시판 게시물 가져오기 (번호로)*/
	   @RequestMapping("my_getCommunityByNo.do")
	   public ModelAndView getCommunityByNo(int boardNo, HttpServletRequest request){
		   ModelAndView mv = new ModelAndView("my_community_info");
		      BoardVO vo = (CommunityBoardVO)communityBoardService.getCommunityByNo(boardNo);
		   
		      
		     List<ReplyVO> list = communityBoardService.getReplyListByNo(boardNo);
		     
		         communityBoardService.updateHits(boardNo);
		      
		      
		      //처음에 상세보기로 넘어가려 할 때 pnvo값으로 현재 로그인 한 아이디 값과 게시판 번호를 가지고 온다.
		      HttpSession session = request.getSession(false);
		      MomentorMemberPhysicalVO pnvo = (MomentorMemberPhysicalVO)session.getAttribute("pnvo");
		      Map<String, String> map = null;
		      if(session!=null&&pnvo!=null){
		    	  
		    	  map = communityBoardService.getRecommendInfoByMemberId(boardNo, pnvo.getMomentorMemberVO().getMemberId());
		      }
		      
		      if(map!=null){
		    	  mv.addObject("recommendInfo", map);
		      }
		      mv.addObject("info", vo);
		      mv.addObject("replyList", list);
		      
	      return mv;
	      
	   }
	
	/*운동게시물 보여주기*/   
	@RequestMapping("member_exerciseBoard.do")
	public ModelAndView member_exerciseBoard(String pageNo){
		ModelAndView mv = new ModelAndView("member_exerciseBoard");
		ListVO vo = exerciseBoardService.getExerciseBoardList(pageNo);
		
		ArrayList<ExerciseBoardVO> list = (ArrayList)vo.getList();
		PagingBean pb = vo.getPagingBean();
		
		mv.addObject("exerciseList", list);
		mv.addObject("pageObject", pb);
		return mv;
	}
	/*관리자용 운동게시판 글쓰기 jsp로 넘어가기*/
	@RequestMapping("admin_contentmgr_writeView.do")
	public String writeViewByAdmin(){
		
		return "admin_contentmgr_write_view";
	}
	/*ajax로 중복되는 운동명 검사*/
	@RequestMapping("checkExerciseName.do")
	@ResponseBody
	public String checkExerciseName(String exerciseName){
		String result = exerciseBoardService.checkExerciseByExerciseName(exerciseName);
		
		return result;
	}
	
	/*운동 게시물 상세보기*/
	@RequestMapping("member_getExerciseByNo.do")
	public ModelAndView getExerciseByNo(int boardNo,String pageNo){
		ModelAndView mv = new ModelAndView("member_exercise_info");
	
		Map<String, Object> map = 
		exerciseBoardService.getExerciseByNo(boardNo);
		
		mv.addObject("exerciseInfo", map.get("exerciseInfo"));
		mv.addObject("nameList", map.get("nameList"));
			exerciseBoardService.updateExerciseHits(boardNo);
		return  mv;
	}
	
	/*???멤버에 노히트가 필요합니까..?*/
	@RequestMapping("admin_getExerciseNoHitByNo.do")
	public ModelAndView getExerciseNoHitByNo(int boardNo){
		Map<String, Object> map  = exerciseBoardService.getExerciseByNo(boardNo);
		ModelAndView mv = new ModelAndView("member_exercise_info");
		
		mv.addObject("exerciseInfo", map.get("exerciseInfo"));
		mv.addObject("nameList", map.get("nameList"));
		return mv;
	}
	/*관리자 운동게시물 글쓰기*/
	@RequestMapping("admin_postingExerciseByAdmin.do")
	public ModelAndView postingExerciseByAdmin(ExerciseVO evo, ExerciseBoardVO ebvo,FileVO vo){
		ebvo.setExerciseVO(evo);
		exerciseBoardService.postingExerciseByAdmin(ebvo);
		
		List<MultipartFile> list = vo.getFile();
		//view 화면에 업로드 된 파일 목록을 전달하기 위한 리스트
		ArrayList<String> nameList = new ArrayList<String>();
		for (int i = 0; i < list.size(); i++) {
			// 만약 업로드 파일이 없으면 파일명은 공란처리 된다.
			String fileName = (list.get(i).getOriginalFilename());
			// 업로드 파일이 있으면 파일을 특정 경로로 업로드한다.
			if (!fileName.equals("")) {
				try {File f = new File(path+evo.getExerciseName()+"_"+fileName);
				
					list.get(i).transferTo(f);
					
					exerciseBoardService.insertUploadFile(evo.getExerciseName(), fileName, path+evo.getExerciseName()+"_"+fileName);
					System.out.println(fileName +"업로드 완료");
					nameList.add(fileName);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}

		}
		ModelAndView mv = new ModelAndView("redirect:admin_getExerciseNoHitByNo.do");
		mv.addObject("boardNo", ebvo.getBoardNo());
		
		return mv;
	}
	
	/*관리자 운동게시물 수정전 값 뿌려주기*/
	@RequestMapping("admin_updateViewForAdmin.do")
	public ModelAndView updateViewForAdmin(int eboardNo){
		Map<String, Object> map  = exerciseBoardService.getExerciseByNo(eboardNo);
		ModelAndView mv = new ModelAndView("admin_contentmgr_update_view");
		
		mv.addObject("exerciseInfo", map.get("exerciseInfo"));
		mv.addObject("nameList", map.get("nameList"));
		return mv;
	}
	
	/*관리자 운동게시물 수정*/
	@RequestMapping("admin_updateExerciseByAdmin.do")
	public String updateExerciseByAdmin(ExerciseVO evo, ExerciseBoardVO ebvo,FileVO vo){
exerciseBoardService.updateExerciseByAdmin(ebvo, evo);
		
		
		List<MultipartFile> list = vo.getFile();
		//view 화면에 업로드 된 파일 목록을 전달하기 위한 리스트
		ArrayList<String> nameList = new ArrayList<String>();
		for (int i = 0; i < list.size(); i++) {
			// 만약 업로드 파일이 없으면 파일명은 공란처리 된다.
			String fileName = (list.get(i).getOriginalFilename());
			
			
			// 업로드 파일이 있으면 파일을 특정 경로로 업로드한다.
			if (!fileName.equals("")) {		
				
				try {File f = new File(path+evo.getExerciseName()+"_"+fileName);
				
					list.get(i).transferTo(f);
					
					exerciseBoardService.insertUploadFile(evo.getExerciseName(), fileName, path+evo.getExerciseName()+"_"+fileName);
					System.out.println(fileName +"업로드 완료");
					nameList.add(fileName);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}

		}
		
		
		return "redirect:admin_getExerciseNoHitByNo.do?boardNo="+ebvo.getBoardNo();
	}
	/*관리자 운동 게시물 삭제 */
	@RequestMapping("admin_deleteExerciseByAdmin.do")
	public String admin_deleteExerciseByAdmin(int eboardNo, String exerciseName){
		exerciseBoardService.deleteExerciseByAdmin(eboardNo,exerciseName);
		return "redirect:member_exerciseBoard.do";
	}
	/*커뮤니티 게시판 게시물 삭제*/
	@RequestMapping("my_deleteCommunity.do")
	public ModelAndView deleteCommunity(int boardNo){
		communityBoardService.deleteCommunity(boardNo);
		return new ModelAndView("redirect:/showCommunityList.do");	
	}
	/*커뮤니티 게시판 게시물 수정 페이지로 이동*/
	@RequestMapping("my_updateCommunityForm.do")
	public ModelAndView updateForm(int boardNo){
		CommunityBoardVO cvo = communityBoardService.getCommunityByNo(boardNo);
		return new ModelAndView("my_updateCommunityForm", "cvo", cvo);
	}
	/* 커뮤니티 게시판 게시물 수정 */
	@RequestMapping(value = "my_updateCommunity.do", method = RequestMethod.POST)
	public ModelAndView updateCommunity(CommunityBoardVO cvo) {
		communityBoardService.updateCommunity(cvo);
		return new ModelAndView("redirect:/member_ getCommunityNoHitByNo.do","boardNo", cvo.getBoardNo());
	}
	
	/* 덧글 리스트 반환 */
	@RequestMapping("my_getReplyList.do")
	@ResponseBody
	public List<ReplyVO> getReplyList(int boardNo) {
		List<ReplyVO> replyList = communityBoardService.getReplyListByNo(boardNo);
		return replyList;
	}
	/* 덧글 번호로 덧글 반환 */
	@RequestMapping("my_getReplyByNo.do")
	@ResponseBody
	public ReplyVO getReplyByNo(int replyNo) {
		ReplyVO rvo = communityBoardService.getReplyByNo(replyNo);
		return rvo;
	}

	/* 덧글 수정 */
	@RequestMapping("my_updateReply.do")
	@ResponseBody
	public List<ReplyVO> updateReply(int replyNo, String updateReplyContent,int boardNo) {
		System.out.println(boardNo);
		ReplyVO rvo = new ReplyVO();
		rvo.setReplyNo(replyNo);
		rvo.setContent(updateReplyContent);
		communityBoardService.updateReply(rvo);
		List<ReplyVO> replyList = communityBoardService.getReplyListByNo(boardNo);
		return replyList;
	}
	/* 덧글 등록(커뮤니티) */
	@RequestMapping(value = "my_registReply.do", method = RequestMethod.POST)
	@ResponseBody
	public List<ReplyVO> registReply(ReplyVO rvo) {
		communityBoardService.postingReply(rvo);
		List<ReplyVO> replyList = communityBoardService.getReplyListByNo(rvo.getCommunityBoardVO().getBoardNo());
		return replyList;
	}
	/* 덧글 삭제(커뮤니티) */
	@RequestMapping("my_deleteReply.do")
	@ResponseBody
	public List<ReplyVO> deleteReply(int replyNo, int boardNo) {
		communityBoardService.deleteReply(replyNo);
		List<ReplyVO> replyList = communityBoardService.getReplyListByNo(boardNo);
		return replyList;
	}
	/* 히트수 증가하지 않고 커뮤니티 글 보기 */
	@RequestMapping("member_ getCommunityNoHitByNo.do")
	public ModelAndView getCommunityNoHitByNo(int boardNo){
		//System.out.println("Controller boardNo : "+boardNo);
		BoardVO vo = (CommunityBoardVO)communityBoardService.getCommunityByNo(boardNo);
		List<ReplyVO> list = communityBoardService.getReplyListByNo(boardNo);
		
		ModelAndView mv = new ModelAndView("my_community_info");
		mv.addObject("info", vo);
		mv.addObject("replyList", list);
		return mv;
	}
	
	  @RequestMapping("member_getAllNoticeList.do")
		public ModelAndView MygetAllNoticeList(HttpServletRequest request,String pageNo){
			MomentorMemberVO mvo = (MomentorMemberVO) request.getSession().getAttribute("mvo");
			//ListVO list = noticeBoardService.getAllNoticeList(pageNo);
			return new ModelAndView("member_getAllNoticeList","noticeList",noticeBoardService.getAllNoticeList(pageNo));
		}
	  /*관리자 tails 적용하여 관리자가 공지글 목록리스트를 보기 위해*/
	  	@RequestMapping(value="admin_getAllNoticeList.do")
	  	public ModelAndView AdmingetAllNoticeList(HttpServletRequest request,String pageNo){
		  	return new ModelAndView("admin_getAllNoticeList","noticeList",noticeBoardService.getAllNoticeList(pageNo));
	  	}
		@RequestMapping("member_getNoticeByNo.do")
		public ModelAndView MygetNoticeByNo(int boardNo){
			NoticeBoardVO nvo = noticeBoardService.getNoticeByNo(boardNo);
			return new ModelAndView("member_getNoticeByNo","nvo",nvo);
		}
		/*관리자 tails 적용하여 관리자가 상세내용 불러오기 위해*/
		@RequestMapping("admin_getNoticeByNo.do")
		public ModelAndView AdmingetNoticeByNo(int boardNo){
			NoticeBoardVO nvo = noticeBoardService.getNoticeByNo(boardNo);
			return new ModelAndView("admin_getNoticeByNo","nvo",nvo);
		}
		/*관리자가 공지사항 글작성 하는 form*/
		@RequestMapping("admin_noticemgr_writeNoticeByAdminForm.do")
		public ModelAndView writeNoticeByAdminForm(HttpServletRequest request){
			MomentorMemberPhysicalVO pnvo = (MomentorMemberPhysicalVO) request.getSession().getAttribute("pnvo");
			System.out.println(pnvo);
			return new ModelAndView("admin_noticemgr_writeNoticeByAdminForm","pnvo",pnvo);
		}
		
		/*관리자가 공지사항 글작성*/
		@RequestMapping("admin_noticemgr_writeNoticeByAdmin.do")
		public ModelAndView writeNoticeByAdmin(HttpServletRequest request, NoticeBoardVO nvo){
			HttpSession session = request.getSession(false);
			MomentorMemberPhysicalVO pnvo =  (MomentorMemberPhysicalVO) session.getAttribute("pnvo");
			nvo.setMomentorMemberVO(pnvo.getMomentorMemberVO());
			noticeBoardService.writeNoticeByAdmin(nvo);
			return new ModelAndView("admin_noticemgr_writeNoticeResult","nvo",nvo);
		}
		/*관리자가 공지사항 글 수정 form*/
		@RequestMapping(value="admin_noticemgr_noticeUpdateForm.do")
		public ModelAndView noticeUpdateForm(int noticeNo){
			NoticeBoardVO nvo = noticeBoardService.getNoticeByNo(noticeNo);
			return new ModelAndView("admin_noticemgr_noticeUpdateForm","nvo",nvo);
		}
		/*관리자가 공지사항 글 수정*/
		@RequestMapping(value="admin_noticemgr_noticeUpdate.do", method=RequestMethod.POST)
		public ModelAndView noticeUpdate(HttpServletRequest request, NoticeBoardVO nvo){
			noticeBoardService.updateNoticeByAdmin(nvo);
			return new ModelAndView("admin_noticemgr_noticeUpdateResult","nvo",nvo);
		}
		/*관리자가 공지사항 글 삭제*/
		@RequestMapping(value="admin_noticemgr_noticeDelete.do")
		public ModelAndView noticeDelete(HttpServletRequest request, int noticeNo){
			System.out.println("admin_noticemgr_noticeDelete.do -> nvo : " + noticeNo);
			noticeBoardService.deleteNoticeByAdmin(noticeNo);
			return new ModelAndView("admin_noticemgr_noticeDeleteResult");
		}
		/**
		 * 추천/비추천 ajax로 하는 부분.
		 * 
		 * @param memberId
		 * @param boardNo
		 * @param recommend
		 * @param notRecommend
		 * @return
		 */
		@RequestMapping("my_updateRecommendInfo.do")
		@ResponseBody
		public Map<String, String> updateRecommendInfo(String memberId, int boardNo,String recommend, String notRecommend){
			int num=0;
		
			
			communityBoardService.updateRecommendInfo(boardNo, memberId, recommend, notRecommend);
			
			
			
		if ((recommend!=null&&recommend.equals("Y"))||(notRecommend!=null&&notRecommend.equals("Y"))) {
			num = 1;
		} else {
			num = -1;
		}
		if (recommend != null && !recommend.equals("")) {
			communityBoardService.updateRecommend(boardNo, num);
			num = 0;
		} else if (notRecommend != null && !notRecommend.equals("")) {
			communityBoardService.updateNotRecommend(boardNo, num);
			num = 0;
		}
		String count[] = communityBoardService.countRecommend(boardNo);
		Map<String, String> map = communityBoardService.getRecommendInfoByMemberId(boardNo, memberId);
		
		map.put("recommendCount", count[0]);
		map.put("notRecommendCount", count[1]);

		return map;
		}
		
		
		@RequestMapping("member_findResult.do") // 전체 검색하기
		public ModelAndView findByTitle(String word){
			List<ExerciseBoardVO> ebList = exerciseBoardService.findByTitle(word); // 운동게시판 검색
			List<CommunityBoardVO> cbList = communityBoardService.findByTitle(word); // 커뮤니티 검색
			List<ExerciseBoardVO> elist = new ArrayList<ExerciseBoardVO>(); // 운동게시판 5개씩 검색
			List<CommunityBoardVO> clist = new ArrayList<CommunityBoardVO>(); // 커뮤니티 5개씩 검색
			if(cbList.size() >= 5){
				for(int i=0;i<5;i++){
					clist.add(cbList.get(i));
				}
			} else{
				for(int i=0;i<cbList.size();i++){
					clist.add(cbList.get(i));
				}
			}
			if(ebList.size() >= 5){
				for(int i=0;i<5;i++){
					elist.add(ebList.get(i));
				}
			} else{
				for(int i=0;i<ebList.size();i++){
					elist.add(ebList.get(i));
				}
			}
			ModelAndView mv = new ModelAndView("member_findResult");
			mv.addObject("word", word); // 검색어 전송
			mv.addObject("totalEbList", ebList); // 전체 운동게시물 검색 수
			mv.addObject("totalCbList", cbList); // 전체 커뮤니티 검색 수
			mv.addObject("ebList", elist); // 화면에 보여지는 운동게시물
			mv.addObject("cbList", clist); // 화면에 보여지는 커뮤니티
			return mv;
		}
		@RequestMapping("member_showSearchCommunity.do") // 커뮤니티 전체 검색 페이지로 이동
		public ModelAndView showSearchCommunity(String word, String pageNo){
			ModelAndView mv = new ModelAndView("member_showSearchCommunity");
			mv.addObject("word", word);
			mv.addObject("list", communityBoardService.getSearchCommunityList(pageNo, word));
			return mv;			
		}
		@RequestMapping("member_showSearchExercise.do") // 운동게시판 전체 검색 페이지로 이동
		public ModelAndView showSearchExercise(String word, String pageNo){
			ModelAndView mv = new ModelAndView("member_showSearchExercise");
			mv.addObject("word", word);
			mv.addObject("list", exerciseBoardService.getSearchExerciseList(pageNo, word));
			return mv;			
		}
		
		/*뭐하는 아일까..?*/
		@RequestMapping("admin_writeView.do")
		public String writeViewFileByAdmin(){
			
			return "admin_contentmgr_write_view";
		}
		
		
		@Resource(name = "uploadPath")
		private String path;
		
		/*운동게시물 상세보기 (사진포함)
		@RequestMapping("member_getExerciseByNo.do")
		public ModelAndView member_getExerciseByNo(int boardNo,String pageNo){
			ModelAndView mv = new ModelAndView("member_exerciseFile_info");
		
			Map<String, Object> map = 
			exerciseBoardService.getExerciseByNo(boardNo);
			
			mv.addObject("exerciseInfo", map.get("exerciseInfo"));
			mv.addObject("nameList", map.get("nameList"));
				exerciseBoardService.updateExerciseHits(boardNo);
			return  mv;
		}*/
		
		
		/*ajax 운동게시물 사진 개별 삭제*/
		@RequestMapping("admin_deleteExerciseImgFileByImgName.do")
		@ResponseBody
		public List<Map<String, String>> deleteExerciseImgFileByImgName(String exerciseName,String imgName){

		System.out.println("exerciseName : " + exerciseName);
		System.out.println("imgName: " + imgName);

		exerciseBoardService.deleteExerciseImgFileByImgName(exerciseName,
				imgName);

		List<Map<String, String>> list = exerciseBoardService
				.getFileListByExerciseName(exerciseName);
			System.out.println(list);
		return list;
		}
		
		// 커뮤니티 게시판 타이틀, 닉네임 검색
		@RequestMapping("member_searchByCommunityBoard.do")
		public ModelAndView searchByCommunityBoard(String pageNo, String searchWord, String searchType){
			ModelAndView mv = new ModelAndView();
			mv.addObject("word", searchWord);
			if(searchType.equals("cbTitle")){
				mv.addObject("list", communityBoardService.getSearchCommunityList(pageNo, searchWord));
			} else if(searchType.equals("mNickName")) {
				mv.addObject("list", communityBoardService.findByCbNickName(pageNo, searchWord));
			}
			mv.setViewName("member_showSearchCommunity");
			return mv;
		}
}
