package org.kosta.momentor.member.model;

public class MomentorMemberVO {
	private String memberId;			//아이디
	private String memberPassword;	//패스워드
	private String memberName;		//이름
	private int birthYear;		//년도
	private int birthMonth;	//월
	private int birthDay;		//일
	private String nickName;	//별명
	private String memberEmail;		//이메일
	private String gender;		//성별
	private String memberAddress;	//주소
	private int auth;			//관리자와 일반회원 비교
	public MomentorMemberVO() {
		super();
	}
	public MomentorMemberVO(String memberId, String memberPassword,
			String memberName, int birtyhYear, int birthMonth, int birthDay,
			String nickName, String memberEmail, String gender,
			String memberAddress, int auth) {
		super();
		this.memberId = memberId;
		this.memberPassword = memberPassword;
		this.memberName = memberName;
		this.birthYear = birtyhYear;
		this.birthMonth = birthMonth;
		this.birthDay = birthDay;
		this.nickName = nickName;
		this.memberEmail = memberEmail;
		this.gender = gender;
		this.memberAddress = memberAddress;
		this.auth = auth;
	}
	public String getMemberId() {
		return memberId;
	}
	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}
	public String getMemberPassword() {
		return memberPassword;
	}
	public void setMemberPassword(String memberPassword) {
		this.memberPassword = memberPassword;
	}
	public String getMemberName() {
		return memberName;
	}
	public void setMemberName(String memberName) {
		this.memberName = memberName;
	}
	public int getBirthYear() {
		return birthYear;
	}
	public void setBirthYear(int birthYear) {
		this.birthYear = birthYear;
	}
	public int getBirthMonth() {
		return birthMonth;
	}
	public void setBirthMonth(int birthMonth) {
		this.birthMonth = birthMonth;
	}
	public int getBirthDay() {
		return birthDay;
	}
	public void setBirthDay(int birthDay) {
		this.birthDay = birthDay;
	}
	public String getNickName() {
		return nickName;
	}
	public void setNickName(String nickName) {
		this.nickName = nickName;
	}
	public String getMemberEmail() {
		return memberEmail;
	}
	public void setMemberEmail(String memberEmail) {
		this.memberEmail = memberEmail;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getMemberAddress() {
		return memberAddress;
	}
	public void setMemberAddress(String memberAddress) {
		this.memberAddress = memberAddress;
	}
	public int getAuth() {
		return auth;
	}
	public void setAuth(int auth) {
		this.auth = auth;
	}
	@Override
	public String toString() {
		return "MomentorMemberVO [memberId=" + memberId + ", memberPassword="
				+ memberPassword + ", memberName=" + memberName
				+ ", birtyhYear=" + birthYear + ", birthMonth=" + birthMonth
				+ ", birthDay=" + birthDay + ", nickName=" + nickName
				+ ", memberEmail=" + memberEmail + ", gender=" + gender
				+ ", memberAddress=" + memberAddress + ", auth=" + auth + "]";
	}


	
}
