package org.kosta.momentor.contents.model;

import java.util.List;

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
}