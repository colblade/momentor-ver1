package org.kosta.momentor.cart.model;

import org.kosta.momentor.contents.model.ExerciseBoardVO;
import org.kosta.momentor.member.model.MomentorMemberVO;

public class CartVO {
	private MomentorMemberVO momentorMemberVO;
	private ExerciseBoardVO exerciseBoardVO;
	
	public CartVO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public CartVO(MomentorMemberVO momentorMemberVO,
			ExerciseBoardVO exerciseBoardVO) {
		super();
		this.momentorMemberVO = momentorMemberVO;
		this.exerciseBoardVO = exerciseBoardVO;
	}
	public MomentorMemberVO getMomentorMemberVO() {
		return momentorMemberVO;
	}
	public void setMomentorMemberVO(MomentorMemberVO momentorMemberVO) {
		this.momentorMemberVO = momentorMemberVO;
	}
	public ExerciseBoardVO getExerciseBoardVO() {
		return exerciseBoardVO;
	}
	public void setExerciseBoardVO(ExerciseBoardVO exerciseBoardVO) {
		this.exerciseBoardVO = exerciseBoardVO;
	}
	@Override
	public String toString() {
		return "CartVO [momentorMemberVO=" + momentorMemberVO
				+ ", exerciseBoardVO=" + exerciseBoardVO + "]";
	}
	
}
