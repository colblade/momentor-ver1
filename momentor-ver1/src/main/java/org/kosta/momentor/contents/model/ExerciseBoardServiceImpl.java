package org.kosta.momentor.contents.model;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.kosta.momentor.cart.model.ExerciseVO;
import org.springframework.stereotype.Service;

@Service
public class ExerciseBoardServiceImpl implements ExerciseBoardService {
	@Resource
	private ExerciseBoardDAO exerciseBoardDAO;

	@Override
	public void postingExerciseByAdmin(ExerciseBoardVO evo) {
		exerciseBoardDAO.registerExercise(evo.getExerciseVO());
		exerciseBoardDAO.postingExerciseByAdmin(evo);
		
	}

	@Override
	public void deleteExerciseByAdmin(int eboardNo, String exerciseName) {
				//먼저 게시물을 지우고 그 다음
				//운동을 지운다.
		exerciseBoardDAO.deleteExerciseBoardByAdmin(eboardNo);
		exerciseBoardDAO.deleteExerciseByAdmin(exerciseName);
		
	}

	@Override
	public void updateExerciseByAdmin(ExerciseBoardVO ebvo,ExerciseVO evo) {
		exerciseBoardDAO.updateExerciseByAdmin( evo);
		exerciseBoardDAO.updateExerciseBoardByAdmin(ebvo);
	}

	@Override
	public ReplyVO postingReply(ReplyVO rvo) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void deleteReply(int mboardNo) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void updateReply(int mboardNo) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public ListVO getExerciseBoardList(String pageNo) {

		if(pageNo==null||pageNo.equals("")){
			pageNo = "1";
		}
		
		ArrayList<BoardVO> list = (ArrayList)exerciseBoardDAO.getExerciseBoardList(pageNo);
		
		PagingBean pagingBean = new PagingBean(exerciseBoardDAO.countAllExerciseBoard(), Integer.parseInt(pageNo));
		ListVO vo = new ListVO(list, pagingBean);
		
		
		return vo;
	}

	@Override
	public String checkExerciseByExerciseName(String exerciseName) {
		int res = exerciseBoardDAO.checkExerciseByExerciseName(exerciseName);
		String result = "false";
		if(res==0){
			result = "true";
		}
		return result;
	}

	@Override
	public ExerciseBoardVO getExerciseByNo(int boardNo) {
		// TODO Auto-generated method stub
		return exerciseBoardDAO.getExerciseByNo(boardNo);
	}

	@Override
	public void updateExerciseHits(int boardNo) {
		exerciseBoardDAO.updateExerciseHits(boardNo);
		
	}

	@Override
	public List<ExerciseBoardVO> getExerciseBoardListBestTop5ByHits() {
		return exerciseBoardDAO.getExerciseBoardListBestTop5ByHits();
	}
	@Override
	public List<ExerciseBoardVO> findByTitle(String word) {
		// 운동게시판 전체 검색
		return exerciseBoardDAO.findByTitle(word);
	}
	 public ListVO getSearchExerciseList(String pageNo, String word) {
		 // 운동 게시판 검색 페이지
			if(pageNo==null||pageNo=="") 
				pageNo="1";
			int total=exerciseBoardDAO.searchExerciseContent(word);
			ArrayList<BoardVO> list= null;
			HashMap<String, String> paramMap = new HashMap<String, String>();
			paramMap.put("word", word);
			paramMap.put("pageNo", pageNo);
			list = (ArrayList)exerciseBoardDAO.getSearchExerciseList(paramMap);
			PagingBean paging=new PagingBean(total,Integer.parseInt(pageNo));
			ListVO lvo=new ListVO(list,paging);
	      return lvo;
	   }
}
