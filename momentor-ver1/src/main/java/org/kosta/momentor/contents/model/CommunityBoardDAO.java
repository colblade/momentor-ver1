package org.kosta.momentor.contents.model;

import java.util.List;

public interface CommunityBoardDAO {
	public CommunityBoardVO postingCommunity(CommunityBoardVO cvo);//글 업로드
	public void deleteCommunity(int cboardNo);//글 수정
	public List<CommunityBoardVO> findByCbTitle(String cbTitle);//제목으로 글검색
	public List<CommunityBoardVO> findByCbNickName(String nickName);//닉네임으로 검색
	public void updateNotRecommend(int cbNotRecommend);//비추천
	public List<CommunityBoardVO> getAllPostingList(); //전체목록
	public void updateHits(int boardNo); //조회수 증가
	public List<ReplyVO> getReplyListByNo(int boardNo);//커뮤니티 글 상세 보기 + 댓글 보기
	public List<CommunityBoardVO> getCommunityBoardListBestTop5ByRecommend();//커뮤니티 게시판 추천수 TOP5
	public void updateCommunity(CommunityBoardVO cvo);
	public ReplyVO postingReply(ReplyVO rvo);//댓글 등록
	public void deleteReply(int cboardNo);//댓글 삭제
	public void updateReply(int cboardNo);//댓글 등록
	public void updateRecommend(int cbRecommend);//추천
	public List<BoardVO> getAllPostingList(String pageNo); //전체목록
	public CommunityBoardVO getCommunityByNo(int boardNo);//커뮤니티글 상세보기
	public int totalContent();
}


