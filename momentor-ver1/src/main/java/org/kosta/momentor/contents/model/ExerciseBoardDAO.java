package org.kosta.momentor.contents.model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.kosta.momentor.cart.model.ExerciseVO;

public interface ExerciseBoardDAO {
public void postingExerciseByAdmin(ExerciseBoardVO evo);//운동 게시물 업로드
public void deleteExerciseBoardByAdmin(int eboardNo);//글 삭제
public void updateExerciseBoardByAdmin(ExerciseBoardVO ebvo);//글 수정
//public ReplyVO postingReply(ReplyVO rvo);//댓글 등록
public void deleteReply(int mboardNo);//댓글 삭제
public void updateReply(int mboardNo);//댓글 등록

//전체 운동 게시물 뿌려주기
public List<BoardVO> getExerciseBoardList(String pageNo);
//전체 페이지 수 계산
public int countAllExerciseBoard();
//운동 이름이 이미 존재하는지 검사
public int checkExerciseByExerciseName(String exerciseName);

//운동 업로드
public void registerExercise(ExerciseVO evo);
//운동 상세보기
public ExerciseBoardVO getExerciseByNo(int boardNo);
//운동게시물의 조회수 증가
public void updateExerciseHits(int boardNo);
//운동 삭제
public void deleteExerciseByAdmin(String exerciseName);
//운동 수정
public void updateExerciseByAdmin(ExerciseVO evo);
public List<ExerciseBoardVO> getExerciseBoardListBestTop5ByHits();
public List<ExerciseBoardVO> findByTitle(String word); // 운동게시판 전체 검색
public List<ExerciseBoardVO> getSearchExerciseList(HashMap<String, String> paramMap); // 운동게시판 검색 페이지
public int searchExerciseContent(String word); // 운동게시판 검색 총 개수

//파일 업로드
public void registerImgFile(Map<String, String> map); 
//파일 리스트 불러오기
public List<Map<String, String>> getFileListByExerciseName(String exerciseName);

//사진 파일 삭제
public void deleteExerciseImgFile(String exerciseName);

//사진파일 개별삭제
public void deleteExerciseImgFileByImgName(Map<String, String> map);

}