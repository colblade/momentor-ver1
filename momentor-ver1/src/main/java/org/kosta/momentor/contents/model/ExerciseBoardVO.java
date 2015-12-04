package org.kosta.momentor.contents.model;

import org.kosta.momentor.cart.model.ExerciseVO;
import org.kosta.momentor.member.model.MomentorMemberVO;

public class ExerciseBoardVO extends BoardVO{
	private ExerciseVO exerciseVO;
	private int exerciseHits;
	
	public ExerciseBoardVO() {
		super();
		// TODO Auto-generated constructor stub
	}



	public ExerciseBoardVO(int boardNo, MomentorMemberVO momentorMemberVO,
			String boardTitle, String boardWdate, String boardContent,
			int ranking,ExerciseVO exerciseVO, int exerciseHits) {
		super(boardNo, momentorMemberVO, boardTitle, boardWdate, boardContent, ranking);
		this.exerciseVO = exerciseVO;
		this.exerciseHits = exerciseHits;	}




	@Override
	public String toString() {
		return "ExerciseBoardVO [exerciseVO=" + exerciseVO + ", exerciseHits="
				+ exerciseHits + ", getBoardNo()=" + getBoardNo()
				+ ", getMomentorMemberVO()=" + getMomentorMemberVO()
				+ ", getBoardTitle()=" + getBoardTitle() + ", getBoardWdate()="
				+ getBoardWdate() + ", getBoardContent()=" + getBoardContent()
				+ ", getRanking()=" + getRanking() + "]";
	}



	public ExerciseVO getExerciseVO() {
		return exerciseVO;
	}

	public void setExerciseVO(ExerciseVO exerciseVO) {
		this.exerciseVO = exerciseVO;
	}

	public int getExerciseHits() {
		return exerciseHits;
	}

	public void setExerciseHits(int exerciseHits) {
		this.exerciseHits = exerciseHits;
	}




	
}
