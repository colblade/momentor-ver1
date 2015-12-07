package org.kosta.momentor.contents.model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface CommunityBoardDAO {
	public CommunityBoardVO postingCommunity(CommunityBoardVO cvo);//글 업로드
	public void deleteCommunity(int cboardNo);//글 수정
	public List<CommunityBoardVO> findByCbTitle(String cbTitle);//제목으로 글검색
	public List<CommunityBoardVO> findByCbNickName(String nickName);//닉네임으로 검색

	public List<CommunityBoardVO> getAllPostingList(); //전체목록
	public void updateHits(int boardNo); //조회수 증가
	public List<ReplyVO> getReplyListByNo(int boardNo);//커뮤니티 글 상세 보기 + 댓글 보기
	public List<CommunityBoardVO> getCommunityBoardListBestTop5ByRecommend();//커뮤니티 게시판 추천수 TOP5
	public void updateCommunity(CommunityBoardVO cvo);
	public ReplyVO postingReply(ReplyVO rvo);//댓글 등록
	public void deleteReply(int cboardNo);//댓글 삭제
	public void updateReply(int cboardNo);//댓글 등록

	public List<BoardVO> getAllPostingList(String pageNo); //전체목록
	public CommunityBoardVO getCommunityByNo(int boardNo);//커뮤니티글 상세보기
	public int totalContent();
	
	//게시판 추천 수 수정 int boardno, 1 or -1
	public void updateRecommend(Map<String, Integer> map);
	//게시판 비추천 수 수정 int boardNo , 1 or -1
	public void updateNotRecommend(Map<String, Integer> map);
	
	//해당 게시물에서 맨 처음 추천/비추천을 한다면 INSERT
	public void insertRecommendInfo(Map<String,String> map);
	//이미 예전에 추천 비추천을 한 경우가 있다면 UPDATE
	public int updateRecommendInfo(Map<String, String> map);
	//게시글 번호와 아이디를 매개변수로 해당 아이디가 추천했는지 안 했는지 알려준다.
	public Map<String, String> getRecommendInfoByMemberId(Map<String, String> map);
	//전체 추천수 값 가지고 오기
	public int countRecommend(int boardNo);
	
	//전체 비추천수 값 가지고 오기
	public int countNotRecommend(int boardNo);
	public List<CommunityBoardVO> findByTitle(String word); // 커뮤니티 검색
	public List<CommunityBoardVO> getSearchCommunityList(HashMap<String, String> paramMap); // 검색된 커뮤니티 목록
	public int searchContent(String word); // 검색된 커뮤니티 총 개수
}


