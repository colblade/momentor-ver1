package org.kosta.momentor.planner.model;

import java.util.List;

import org.kosta.momentor.cart.model.CartVO;

public interface PlannerService {
	// 플래너에 등록(오늘을 기준으로 이후일 경우만), 달성세트는 입력 불가능
	public void registerExerciseInPlanner(PlannerVO pvo);
	// 목표세트 수정(오늘을 기준으로 이전일 경우만)
	public void updateTargetSetInPlanner(PlannerVO pvo);
	// 코멘트 불러오기
	public String getPlannerContentByDate(PlannerVO pvo);
	// 코멘트 업데이트
	public int updateCommentInPlanner(PlannerVO pvo);
	// 코멘트 등록
	public void registerCommentInPlanner(PlannerVO pvo);
	// 달성세트 입력(오늘만)
	public void updateAchievementInPlanner(PlannerVO pvo);
	// 플래너 리스트 불러오기
	public List<PlannerVO> getPlannerList(String id);
	// 플래너 상세보기 (그 날짜 기준으로)
	public PlannerVO getPlannerByDate(PlannerVO pvo);
	// 플래너 삭제(오늘을 기준으로 이전일 경우만)
	public void deleteExerciseInPlanner(PlannerVO pvo);
	// 플래너 리스트 상세보기 (그 날짜 기준으로) - 그날 운동 한 것들
	public List<PlannerVO> getPlannerListByDate(PlannerVO pvo);
	
	// 카트 리스트 불러오기
	public List<CartVO> getCartList(String id);
	// 카트에 운동 등록하기
	public void registerExerciseInCart(CartVO cvo);
	// 카트 내 운동 삭제하기
	public void deleteExcerciseInCart(CartVO cvo);
}