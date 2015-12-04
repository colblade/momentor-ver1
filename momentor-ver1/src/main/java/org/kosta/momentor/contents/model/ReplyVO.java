package org.kosta.momentor.contents.model;

import org.kosta.momentor.member.model.MomentorMemberVO;

public class ReplyVO {
	private	int replyNo;
	private MomentorMemberVO momentorMemberVO;
	//board로 받는 걸로 수정
	private BoardVO communityBoardVO;
	private String content;
	private String replyDate;
	
	public ReplyVO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public ReplyVO(int replyNo, MomentorMemberVO momentorMemberVO,
			CommunityBoardVO communityBoardVO, String content, String replyDate) {
		super();
		this.replyNo = replyNo;
		this.momentorMemberVO = momentorMemberVO;
		this.communityBoardVO = communityBoardVO;
		this.content = content;
		this.replyDate = replyDate;
	}
	public int getReplyNo() {
		return replyNo;
	}
	public void setReplyNo(int replyNo) {
		this.replyNo = replyNo;
	}
	public MomentorMemberVO getMomentorMemberVO() {
		return momentorMemberVO;
	}
	public void setMomentorMemberVO(MomentorMemberVO momentorMemberVO) {
		this.momentorMemberVO = momentorMemberVO;
	}
	public CommunityBoardVO getCommunityBoardVO() {
		return (CommunityBoardVO) communityBoardVO;
	}
	public void setCommunityBoardVO(CommunityBoardVO communityBoardVO) {
		this.communityBoardVO = communityBoardVO;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getReplyDate() {
		return replyDate;
	}
	public void setReplyDate(String replyDate) {
		this.replyDate = replyDate;
	}
	@Override
	public String toString() {
		return "ReplyVO [replyNo=" + replyNo + ", momentorMemberVO="
				+ momentorMemberVO + ", communityBoardVO=" + communityBoardVO
				+ ", content=" + content + ", replyDate=" + replyDate + "]";
	}
	
}
