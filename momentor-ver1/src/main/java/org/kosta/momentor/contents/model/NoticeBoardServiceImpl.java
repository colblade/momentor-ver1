package org.kosta.momentor.contents.model;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

@Service
public class NoticeBoardServiceImpl implements NoticeBoardService {
	@Resource
	private NoticeBoardDAO noticeBoardDAO;

	@Override
	public NoticeBoardVO writeNoticeByAdmin(NoticeBoardVO nvo) {
		System.out.println("service" + nvo);
		return noticeBoardDAO.writeNoticeByAdmin(nvo);
	}

	@Override
	public void deleteNoticeByAdmin(int noticeNo) {
		noticeBoardDAO.deleteNoticeByAdmin(noticeNo);
		
	}

	@Override
	public void updateNoticeByAdmin(int noticeNo) {
		noticeBoardDAO.updateNoticeByAdmin(noticeNo);
	}

	@Override
	public ListVO getAllNoticeList(String pageNo) {
		if(pageNo==null||pageNo==""){ 
			pageNo="1";
		}
		List<BoardVO> noticeList = noticeBoardDAO.getAllNoticeList(pageNo);
		int total = noticeBoardDAO.totalNoticeContent();
		PagingBean paging=new PagingBean(total,Integer.parseInt(pageNo));
		ListVO lvo = new ListVO((ArrayList<BoardVO>) noticeList,paging);
		return lvo;
	}

	@Override
	public NoticeBoardVO getNoticeByNo(int boardNo) {
		return noticeBoardDAO.getNoticeByNo(boardNo);
	}

}
