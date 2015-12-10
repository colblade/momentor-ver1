package org.kosta.momentor.contents.model;

import java.util.List;
import java.util.Map;

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
	
	public void updateExerciseHits(int boardNo);
	public List<ExerciseBoardVO> getExerciseBoardListBestTop5ByHits();
	public List<ExerciseBoardVO> findByTitle(String word); // 운동게시판 검색
	public ListVO getSearchExerciseList(String pageNo, String word) ; // 운동게시판 검색 페이지


	//사진 올리기
	public void insertUploadFile(String exerciseName, String imgName, String imgPath);
	
	//운동게시물 상세보기
	public Map<String, Object> getExerciseByNo(int boardNo);
	
	//사진 개별 삭제
	public void deleteExerciseImgFileByImgName(String exerciseName, String imgName);
	//사진 가지고 오기
	public List<Map<String, String>> getFileListByExerciseName(String exerciseName);

}