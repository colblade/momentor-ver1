package org.kosta.momentor.planner.model;

import java.util.List;

public interface PlannerDAO {
	public List<PlannerVO> getPlannerList(String id); // 홈에서 해당회원의 각 날짜별 플래너 리스트 출력
	public List<PlannerVO> getPlannerListByDate(PlannerVO pvo); // 해당일의 플래너에 등록된 운동 리스트 출력
	public void registerExerciseInPlanner(PlannerVO pvo); // 플래너에 운동 등록(오늘과 오늘 이후일에만 가능)
	public void deleteExerciseInPlanner(PlannerVO pvo); // 플래너에서 운동 삭제(오늘과 오늘 이후일에만 가능)
	public void updateAchievementInPlanner(PlannerVO pvo); // 플래너에서 달성도 등록(오늘만 가능)
	public void updateTargetSetInPlanner(PlannerVO pvo); // 플래너의 목표세트 수정(오늘을 기준으로 이전일 경우만 가능)
	public PlannerVO getPlannerContentByDate(PlannerVO pvo); // 해당일의 플래너 코멘트 불러오기
	public void registerCommentInPlanner(PlannerVO pvo); // 해당일의 플래너에 코멘트 등록
	public int updateCommentInPlanner(PlannerVO pvo);	 // 해당일의 플래너에 코멘트 수정
}