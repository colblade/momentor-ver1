package org.kosta.momentor.cart.model;

public class ExerciseVO {
	private String exerciseName;
	private String exerciseBody;
	
	public ExerciseVO() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	
	public ExerciseVO(String exerciseName, String exerciseBody) {
		super();
		this.exerciseName = exerciseName;
		this.exerciseBody = exerciseBody;
	}


	public String getExerciseName() {
		return exerciseName;
	}
	public void setExerciseName(String exerciseName) {
		this.exerciseName = exerciseName;
	}
	public String getExerciseBody() {
		return exerciseBody;
	}
	public void setExerciseBody(String exerciseBody) {
		this.exerciseBody = exerciseBody;
	}


	@Override
	public String toString() {
		return "ExerciseVO [exerciseName=" + exerciseName + ", exerciseBody="
				+ exerciseBody + "]";
	}

	



}
