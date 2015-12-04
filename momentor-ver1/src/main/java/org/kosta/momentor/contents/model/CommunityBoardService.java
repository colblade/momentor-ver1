package org.kosta.momentor.contents.model;

import java.util.List;
public interface CommunityBoardService {
	public CommunityBoardVO postingCommunity(CommunityBoardVO cvo);//글 업로드.
	public void deleteCommunity(int cboardNo);//글 삭제.
	public void updateCommunity(CommunityBoardVO cvo);//글 수정.
	public ReplyVO postingReply(ReplyVO rvo);//댓글 등록
	public void deleteReply(int cboardNo);//댓글 삭제
	public void updateReply(int cboardNo);//댓글 등록
	public List<CommunityBoardVO> findByCbTitle(String cbTitle);//제목으로 글검색
	public List<CommunityBoardVO> findByCbNickName(String nickName);//닉네임으로 검색
	public void updateRecommend(int cbRecommend);//추천
	public void updateNotRecommend(int cbNotRecommend);//비추천
	public CommunityBoardVO getCommunityByNo(int boardNo);//커뮤니티글 상세보기.
	public void updateHits(int boardNo); //조회수 증가.
	public List<ReplyVO> getReplyListByNo(int boardNo);//커뮤니티 글 상세 보기 + 댓글 보기
	 
	public List<CommunityBoardVO> getCommunityBoardListBestTop5ByRecommend();//커뮤니티 게시판 추천수 TOP5
	public ListVO getAllPostingList(String pageNo);//전체 목록

}
