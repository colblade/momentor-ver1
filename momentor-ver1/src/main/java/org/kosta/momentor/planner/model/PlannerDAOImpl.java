package org.kosta.momentor.planner.model;

import java.util.List;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class PlannerDAOImpl implements PlannerDAO {
	@Resource
	private SqlSessionTemplate sqlSessionTemplate;

	@Override
	public List<PlannerVO> getPlannerList(String id) {
		return sqlSessionTemplate.selectList("plan.getPlannerList", id);
	}
	
	@Override
	public List<PlannerVO> getPlannerListByDate(PlannerVO pvo) {
		return sqlSessionTemplate.selectList("plan.getPlannerListByDate", pvo);
	}
	
	@Override
	public void registerExerciseInPlanner(PlannerVO pvo) {
		sqlSessionTemplate.insert("plan.registerExerciseInPlanner", pvo);
	}

	@Override
	public void deleteExerciseInPlanner(PlannerVO pvo) {
		sqlSessionTemplate.update("plan.deleteExerciseInPlanner", pvo);
	}
	
	@Override
	public void updateAchievementInPlanner(PlannerVO pvo) {
		sqlSessionTemplate.update("plan.updateAchievementInPlanner", pvo);
	}
	
	@Override
	public void updateTargetSetInPlanner(PlannerVO pvo) {
		sqlSessionTemplate.update("plan.updateTargetSetInPlanner", pvo);
	}
	
	@Override
	public PlannerVO getPlannerContentByDate(PlannerVO pvo){
		return sqlSessionTemplate.selectOne("plan.getPlannerContentByDate", pvo);
	}
	
	@Override
	public void registerCommentInPlanner(PlannerVO pvo) {
		sqlSessionTemplate.insert("plan.registerCommentInPlanner", pvo);
	}
	
	@Override
	public int updateCommentInPlanner(PlannerVO pvo) {
		return sqlSessionTemplate.update("plan.updateCommentInPlanner", pvo);
	}
}