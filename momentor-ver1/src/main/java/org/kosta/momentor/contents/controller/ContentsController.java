package org.kosta.momentor.contents.controller;

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
import org.kosta.momentor.contents.model.ListVO;
import org.kosta.momentor.contents.model.NoticeBoardService;
import org.kosta.momentor.contents.model.NoticeBoardVO;
import org.kosta.momentor.contents.model.PagingBean;
import org.kosta.momentor.contents.model.ReplyVO;
import org.kosta.momentor.member.model.MomentorMemberVO;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
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
	   
	   @RequestMapping("showCommunityList.do")
	   public ModelAndView showCommunityList(String pageNo){
	      return new ModelAndView("member_showCommunityList","list",communityBoardService.getAllPostingList(pageNo));
	      //헤더 커뮤니티 버튼 클릭시 나오는 화면
	      //로그인 유무에 따라 분리 해야 하는것인가?->아니라면 로그인시 left는?
	   }
	   
	/*커뮤니티 게시판 글쓰기 폼으로 이동*/
	@RequestMapping("my_writeForm.do")
	public ModelAndView writeForm(HttpServletRequest request){
		return new ModelAndView("my_postingCommunity");
	}

	   /*커뮤니티 게시판 게시물 가져오기 (번호로)*/
	   @RequestMapping("member_getCommunityByNo.do")
	   public ModelAndView getCommunityByNo(int boardNo, @CookieValue(value = "testCookie",required=false) String cookieValue, HttpServletResponse response){
	      //communityBoardService.updateHits(boardNo);
	      ModelAndView mv = new ModelAndView("my_community_info");
	      BoardVO vo = (CommunityBoardVO)communityBoardService.getCommunityByNo(boardNo);
	   
	      /**
	       * pagingbean 적용시키기.
	       */
	      //   ReListVO rvo =new ReListVO(communityBoardService.getReplyListByNo(boardNo),new PagingBean(totalContent, nowPage));
	     List<ReplyVO> list = communityBoardService.getReplyListByNo(boardNo);
	      if(cookieValue ==null){
	         System.out.println("testCookie는 존재하지 않으므로 cookie를 생성하고 count 증가");
	         response.addCookie(new Cookie("testCookie", "|"+boardNo+"|"));
	         communityBoardService.updateHits(boardNo);
	      }else if(cookieValue.indexOf("|"+boardNo+"|")==-1){
	         System.out.println("testCookie cookie 존재하지만 {}글은 처음 조회하므로 count 증가 "+ boardNo);
	      cookieValue+="|"+boardNo+"|";
	      //글번호를 쿠키에 추가
	      response.addCookie(new Cookie("testCookie", cookieValue));
	      communityBoardService.updateHits(boardNo);
	      }else{
	         System.out.println("testCookie cookie 존재하고 이전에 해당하는 게시물을 읽었으므로 count 증가 X");
	      }
	      
	      
	      mv.addObject("info", vo);
	      mv.addObject("replyList", list);
	      return mv;
	      
	   }
	

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
	@RequestMapping("admin_contentmgr_writeView.do")
	public String writeViewByAdmin(){
		
		return "admin_contentmgr_write_view";
	}
	
	@RequestMapping("checkExerciseName.do")
	@ResponseBody
	public String checkExerciseName(String exerciseName){
		String result = exerciseBoardService.checkExerciseByExerciseName(exerciseName);
		
		return result;
	}
	@RequestMapping("member_getExerciseByNo.do")
	public ModelAndView getExerciseByNo(int boardNo){
		exerciseBoardService.updateExerciseHits(boardNo);
		ExerciseBoardVO vo = exerciseBoardService.getExerciseByNo(boardNo);
		return new ModelAndView("member_exercise_info","exerciseInfo",vo);
	}
	@RequestMapping("member_getExerciseNoHitByNo.do")
	public ModelAndView getExerciseNoHitByNo(int boardNo){
		ExerciseBoardVO vo = exerciseBoardService.getExerciseByNo(boardNo);
		return new ModelAndView("member_exercise_info","exerciseInfo",vo);
	}
	
	
	@RequestMapping("admin_postingExerciseByAdmin.do")
	public String postingExerciseByAdmin(ExerciseVO evo, ExerciseBoardVO ebvo){
		System.out.println("evo: "+evo);
		System.out.println("ebvo:"+ ebvo);
		ebvo.setExerciseVO(evo);
		
		exerciseBoardService.postingExerciseByAdmin(ebvo);
		return "redirect:member_getExerciseNoHitByNo.do?boardNo="+ebvo.getBoardNo();
	}
	
	@RequestMapping("admin_updateViewForAdmin.do")
	public ModelAndView updateViewForAdmin(int eboardNo){
		ExerciseBoardVO vo = exerciseBoardService.getExerciseByNo(eboardNo);

		return new ModelAndView("admin_contentmgr_update_view","exerciseInfo",vo);
	}
	
	
	@RequestMapping("admin_updateExerciseByAdmin.do")
	public String updateExerciseByAdmin(ExerciseVO evo, ExerciseBoardVO ebvo){
			System.out.println("ebvo: "+ebvo);
			System.out.println("ebo: "+evo);
		exerciseBoardService.updateExerciseByAdmin(ebvo, evo);
		
		return "redirect:member_getExerciseNoHitByNo.do?boardNo="+ebvo.getBoardNo();
	}
	
	@RequestMapping("admin_deleteExerciseByAdmin.do")
	public String admin_deleteExerciseByAdmin(int eboardNo, String exerciseName){
		exerciseBoardService.deleteExerciseByAdmin(eboardNo,exerciseName);
		return "redirect:member_exerciseBoard.do";
	}
	/*커뮤니티 게시판 게시물 삭제*/
	@RequestMapping("my_deleteCommunity.do")
	public ModelAndView deleteCommunity(int boardNo){
		//System.out.println("삭제 컨트롤러 : "+boardNo);
		communityBoardService.deleteCommunity(boardNo);
		return new ModelAndView("redirect:/showCommunityList.do");	
	}
	/*커뮤니티 게시판 게시물 수정 페이지로 이동*/
	@RequestMapping("my_updateCommunityForm.do")
	public ModelAndView updateForm(int boardNo){
		CommunityBoardVO cbvo=communityBoardService.getCommunityByNo(boardNo);
		//System.out.println("수정 하기 전 게시글 확인 : "+cbvo);
		return new ModelAndView("my_updateCommunityForm","cbvo",cbvo);
	}
	/*커뮤니티 게시판 게시물 수정*/
	@RequestMapping(value="my_updateCommunity.do",method=RequestMethod.POST)
	public ModelAndView updateCommunity(CommunityBoardVO cvo){
		/*System.out.println("수정될 글 내용 : "+cvo);
		System.out.println("게시물 수정 시 게시글 번호 : "+cvo.getBoardNo());*/
		communityBoardService.updateCommunity(cvo);
		return new ModelAndView("redirect:/member_ getCommunityNoHitByNo.do","boardNo",cvo.getBoardNo());
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
		@RequestMapping("member_getNoticeByNo.do")
		public ModelAndView MygetNoticeByNo(int boardNo){
			NoticeBoardVO nvo = noticeBoardService.getNoticeByNo(boardNo);
			return new ModelAndView("member_getNoticeByNo","nvo",nvo);
		}
		
		@RequestMapping("admin_noticemgr_writeNoticeByAdminForm.do")
		public ModelAndView writeNoticeByAdminForm(HttpServletRequest request, MomentorMemberVO mvo){
			return new ModelAndView("admin_noticemgr_writeNoticeByAdminForm");
		}
		
		@RequestMapping("admin_noticemgr_writeNoticeByAdmin.do")
		public ModelAndView writeNoticeByAdmin(HttpServletRequest request, NoticeBoardVO nvo){
			HttpSession session = request.getSession(false);
			MomentorMemberVO mvo = (MomentorMemberVO) session.getAttribute("mvo");
			nvo.setMomentorMemberVO(mvo);
			noticeBoardService.writeNoticeByAdmin(nvo);
			return new ModelAndView("admin_noticemgr_writeNoticeResult","nvo",nvo);
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
}
