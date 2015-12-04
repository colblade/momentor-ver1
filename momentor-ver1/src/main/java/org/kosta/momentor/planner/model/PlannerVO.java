package org.kosta.momentor.planner.model;

import org.kosta.momentor.cart.model.ExerciseVO;
import org.kosta.momentor.member.model.MomentorMemberVO;

public class PlannerVO {

	private MomentorMemberVO momentorMemberVO;
	private ExerciseVO exerciseVO;
	private String plannerContent;
	private String plannerDate;
	private int targetSet;
	private int achievement;
	private int achievementPercent;
	private int achievementPercentDay;
	private int achievementPercentMonth;

	public PlannerVO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public PlannerVO(MomentorMemberVO momentorMemberVO, ExerciseVO exerciseVO,
			String plannerContent, String plannerDate, int targetSet,
			int achievement, int achievementPercent, int achievementPercentDay,
			int achievementPercentMonth) {
		super();
		this.momentorMemberVO = momentorMemberVO;
		this.exerciseVO = exerciseVO;
		this.plannerContent = plannerContent;
		this.plannerDate = plannerDate;
		this.targetSet = targetSet;
		this.achievement = achievement;
		this.achievementPercent = achievementPercent;
		this.achievementPercentDay = achievementPercentDay;
		this.achievementPercentMonth = achievementPercentMonth;
	}

	public MomentorMemberVO getMomentorMemberVO() {
		return momentorMemberVO;
	}

	public void setMomentorMemberVO(MomentorMemberVO momentorMemberVO) {
		this.momentorMemberVO = momentorMemberVO;
	}

	public ExerciseVO getExerciseVO() {
		return exerciseVO;
	}

	public void setExerciseVO(ExerciseVO exerciseVO) {
		this.exerciseVO = exerciseVO;
	}

	public String getPlannerContent() {
		return plannerContent;
	}

	public void setPlannerContent(String plannerContent) {
		this.plannerContent = plannerContent;
	}

	public String getPlannerDate() {
		return plannerDate;
	}

	public void setPlannerDate(String plannerDate) {
		this.plannerDate = plannerDate;
	}

	public int getTargetSet() {
		return targetSet;
	}

	public void setTargetSet(int targetSet) {
		this.targetSet = targetSet;
	}

	public int getAchievement() {
		return achievement;
	}

	public void setAchievement(int achievement) {
		this.achievement = achievement;
	}

	public int getAchievementPercent() {
		return achievementPercent;
	}

	public void setAchievementPercent(int achievementPercent) {
		this.achievementPercent = achievementPercent;
	}

	public int getAchievementPercentDay() {
		return achievementPercentDay;
	}

	public void setAchievementPercentDay(int achievementPercentDay) {
		this.achievementPercentDay = achievementPercentDay;
	}

	public int getAchievementPercentMonth() {
		return achievementPercentMonth;
	}

	public void setAchievementPercentMonth(int achievementPercentMonth) {
		this.achievementPercentMonth = achievementPercentMonth;
	}

	@Override
	public String toString() {
		return "PlannerVO [momentorMemberVO=" + momentorMemberVO
				+ ", exerciseVO=" + exerciseVO + ", plannerContent="
				+ plannerContent + ", plannerDate=" + plannerDate
				+ ", targetSet=" + targetSet + ", achievement=" + achievement
				+ ", achievementPercent=" + achievementPercent
				+ ", achievementPercentDay=" + achievementPercentDay
				+ ", achievementPercentMonth=" + achievementPercentMonth + "]";
	}
	
}
