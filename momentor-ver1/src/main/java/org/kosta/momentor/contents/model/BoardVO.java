package org.kosta.momentor.contents.model;

import org.kosta.momentor.member.model.MomentorMemberVO;

public abstract class BoardVO {
	private int boardNo; 		//공지사항,운동게시판,멤버게시판 글번호
	private MomentorMemberVO momentorMemberVO;
	private String boardTitle; //공지사항,운동게시판,멤버게시판 제목
	private String boardWdate; //공지사항,운동게시판,멤버게시판 작성일자
	private String boardContent; //공지사항,운동게시판,멤버게시판 글 내용
	private int ranking;
	public BoardVO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public int getBoardNo() {
		return boardNo;
	}
	public void setBoardNo(int boardNo) {
		this.boardNo = boardNo;
	}
	public MomentorMemberVO getMomentorMemberVO() {
		return momentorMemberVO;
	}
	public void setMomentorMemberVO(MomentorMemberVO momentorMemberVO) {
		this.momentorMemberVO = momentorMemberVO;
	}
	public String getBoardTitle() {
		return boardTitle;
	}
	public void setBoardTitle(String boardTitle) {
		this.boardTitle = boardTitle;
	}
	public String getBoardWdate() {
		return boardWdate;
	}
	public void setBoardWdate(String boardWdate) {
		this.boardWdate = boardWdate;
	}
	public String getBoardContent() {
		return boardContent;
	}
	public void setBoardContent(String boardContent) {
		this.boardContent = boardContent;
	}
	public int getRanking() {
		return ranking;
	}
	public void setRanking(int ranking) {
		this.ranking = ranking;
	}
	@Override
	public String toString() {
		return "BoardVO [boardNo=" + boardNo + ", momentorMemberVO="
				+ momentorMemberVO + ", boardTitle=" + boardTitle
				+ ", boardWdate=" + boardWdate + ", boardContent="
				+ boardContent + ", ranking=" + ranking + "]";
	}
	public BoardVO(int boardNo, MomentorMemberVO momentorMemberVO,
			String boardTitle, String boardWdate, String boardContent,
			int ranking) {
		super();
		this.boardNo = boardNo;
		this.momentorMemberVO = momentorMemberVO;
		this.boardTitle = boardTitle;
		this.boardWdate = boardWdate;
		this.boardContent = boardContent;
		this.ranking = ranking;
	}
	
	
}
