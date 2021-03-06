package org.kosta.momentor.contents.model;


public interface NoticeBoardService {
	public NoticeBoardVO writeNoticeByAdmin(NoticeBoardVO nvo);//글작성
	public void deleteNoticeByAdmin(int noticeNo);//글 삭제
	public void updateNoticeByAdmin(NoticeBoardVO nvo);//글 수정
	public ListVO getAllNoticeList(String pageNo); //전체목록
	public NoticeBoardVO getNoticeByNo(int boardNo);//공지사항글 상세보기
}