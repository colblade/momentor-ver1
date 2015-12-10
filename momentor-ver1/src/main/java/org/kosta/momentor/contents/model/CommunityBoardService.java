package org.kosta.momentor.contents.model;

import java.util.List;
import java.util.Map;
public interface CommunityBoardService {
	public CommunityBoardVO postingCommunity(CommunityBoardVO cvo);//글 업로드.
	public void deleteCommunity(int cboardNo);//글 삭제.
	public void updateCommunity(CommunityBoardVO cvo);//글 수정.
	public ReplyVO postingReply(ReplyVO rvo);//댓글 등록
	public void deleteReply(int replyNo);//댓글 삭제
	public void updateReply(ReplyVO rvo);//댓글 수정
	public List<CommunityBoardVO> findByCbTitle(String cbTitle);//제목으로 글검색
	public ListVO findByCbNickName(String pageNo, String searchWord);//닉네임으로 검색
	public void updateRecommend(int cbRecommend);//추천
	public void updateNotRecommend(int cbNotRecommend);//비추천
	public CommunityBoardVO getCommunityByNo(int boardNo);//커뮤니티글 상세보기.
	public void updateHits(int boardNo); //조회수 증가.
	public List<ReplyVO> getReplyListByNo(int boardNo);//커뮤니티 글 상세 보기 + 댓글 보기
	public ReplyVO getReplyByNo(int replyNo);//댓글 시퀀스로 단일 댓글 가져오기
	public List<CommunityBoardVO> getCommunityBoardListBestTop5ByRecommend();//커뮤니티 게시판 추천수 TOP5
	public ListVO getAllPostingList(String pageNo);//전체 목록

	
	//해당 커뮤니티 게시물에서 맨 처음 추천/비추천을 한다면 INSERT
	//이미 예전에 추천 비추천을 한 경우가 있다면 UPDATE
	//#{boardNo},#{memberId},#{recommend},#{notrecommend}
	public void updateRecommendInfo(int boardNo, String memberId, String recommend, String notRecommend);
	
	//커뮤니티 추천/비추천수를 수정한다.
	public void updateRecommend(int boardNo, int num);
	public void updateNotRecommend(int boardNo, int num);
	
	//커뮤키티 게시글 번호와 아이디를 매개변수로 해당 아이디가 추천했는지 안 했는지 알려준다.
	public Map<String, String> getRecommendInfoByMemberId(int boardNo, String memberId);	
	
	//해당 커뮤니티 게시글의 추천/비추천수를 가지고 온다.
	public List<CommunityBoardVO> findByTitle(String word); // 커뮤니티 검색
	public ListVO getSearchCommunityList(String pageNo, String word); // 검색된 커뮤니티 목록
	public String[] countRecommend(int boardNo);
}
