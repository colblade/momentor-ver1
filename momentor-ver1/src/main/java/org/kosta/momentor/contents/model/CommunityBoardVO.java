package org.kosta.momentor.contents.model;

import org.kosta.momentor.member.model.MomentorMemberVO;

public class CommunityBoardVO extends BoardVO {
	private int memberHits;		//멤버 게시판 조회수
	private int recommend;		//멤버 게시판 추천수
	private int notRecommend;		//멤버 게시판 비추천수

	public CommunityBoardVO() {
		super();
	}

	public CommunityBoardVO(int boardNo, MomentorMemberVO momentorMemberVO,
			String boardTitle, String boardWdate, String boardContent,
			int ranking,int memberHits, int recommend, int notRecommend) {
		super(boardNo, momentorMemberVO, boardTitle, boardWdate, boardContent, ranking);
		this.memberHits = memberHits;
		this.recommend = recommend;
		this.notRecommend = notRecommend;
	}


	public int getMemberHits() {
		return memberHits;
	}

	public void setMemberHits(int memberHits) {
		this.memberHits = memberHits;
	}

	public int getRecommend() {
		return recommend;
	}

	public void setRecommend(int recommend) {
		this.recommend = recommend;
	}

	public int getNotRecommend() {
		return notRecommend;
	}

	public void setNotRecommend(int notRecommend) {
		this.notRecommend = notRecommend;
	}

	@Override
	public String toString() {
		return "CommunityBoardVO [memberHits=" + memberHits + ", recommend="
				+ recommend + ", notRecommend=" + notRecommend
				+ ", getBoardNo()=" + getBoardNo() + ", getMomentorMemberVO()="
				+ getMomentorMemberVO() + ", getBoardTitle()="
				+ getBoardTitle() + ", getBoardWdate()=" + getBoardWdate()
				+ ", getBoardContent()=" + getBoardContent()
				+ ", getRanking()=" + getRanking() + "]";
	}




	

}
