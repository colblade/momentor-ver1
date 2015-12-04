package org.kosta.momentor.member.model;

public class MomentorMemberPhysicalVO {
	private double memberWeight;		//몸무게
	private double memberHeight;		//키
	private int age;
	private double bmi;
	private MomentorMemberVO momentorMemberVO; //ID
	public MomentorMemberPhysicalVO() {
		super();
	}
	public double getMemberWeight() {
		return memberWeight;
	}
	public void setMemberWeight(double memberWeight) {
		this.memberWeight = memberWeight;
	}
	public double getMemberHeight() {
		return memberHeight;
	}
	public void setMemberHeight(double memberHeight) {
		this.memberHeight = memberHeight;
	}
	public int getAge() {
		return age;
	}
	public void setAge(int age) {
		this.age = age;
	}
	public double getBmi() {
		return bmi;
	}
	public void setBmi(double bmi) {
		this.bmi = bmi;
	}
	public MomentorMemberVO getMomentorMemberVO() {
		return momentorMemberVO;
	}
	public void setMomentorMemberVO(MomentorMemberVO momentorMemberVO) {
		this.momentorMemberVO = momentorMemberVO;
	}
	@Override
	public String toString() {
		return "MomentorMemberPhysicalVO [memberWeight=" + memberWeight
				+ ", memberHeight=" + memberHeight + ", age=" + age + ", bmi="
				+ bmi + ", momentorMemberVO=" + momentorMemberVO + "]";
	}
	public MomentorMemberPhysicalVO(double memberWeight, double memberHeight,
			int age, double bmi, MomentorMemberVO momentorMemberVO) {
		super();
		this.memberWeight = memberWeight;
		this.memberHeight = memberHeight;
		this.age = age;
		this.bmi = bmi;
		this.momentorMemberVO = momentorMemberVO;
	}
		
	
}
