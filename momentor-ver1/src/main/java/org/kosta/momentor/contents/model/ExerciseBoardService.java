package org.kosta.momentor.contents.model;

import java.util.List;

import org.kosta.momentor.cart.model.ExerciseVO;

public interface ExerciseBoardService {
	public void postingExerciseByAdmin(ExerciseBoardVO evo);//운동 업로드
	public void deleteExerciseByAdmin(int eboardNo,String exerciseName);//글 삭제
	public void updateExerciseByAdmin(ExerciseBoardVO ebvo,ExerciseVO evo);//글 수정
	public ReplyVO postingReply(ReplyVO rvo);//댓글 등록
	public void deleteReply(int mboardNo);//댓글 삭제
	public void updateReply(int mboardNo);//댓글 등록
	
	//----------------------------------------
	
	public ListVO getExerciseBoardList(String pageNo);
	public String checkExerciseByExerciseName(String exerciseName);
	public ExerciseBoardVO getExerciseByNo(int boardNo);
	public void updateExerciseHits(int boardNo);
	public List<ExerciseBoardVO> getExerciseBoardListBestTop5ByHits();

}