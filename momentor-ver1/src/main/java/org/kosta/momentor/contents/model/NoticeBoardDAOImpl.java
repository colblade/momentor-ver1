package org.kosta.momentor.contents.model;

import java.util.List;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;
@Repository
public class NoticeBoardDAOImpl implements NoticeBoardDAO {
	@Resource
	private SqlSessionTemplate sqlSessionTemplate;

	@Override
	public NoticeBoardVO writeNoticeByAdmin(NoticeBoardVO nvo) {
		System.out.println("DAO : " + nvo);
		sqlSessionTemplate.insert("content.writeNoticeByAdmin",nvo);
		return nvo;
	}

	@Override
	public void deleteNoticeByAdmin(int noticeNo) {
		sqlSessionTemplate.delete("content.deleteNoticeByAdmin", noticeNo);
		
	}

	@Override
	public void updateNoticeByAdmin(int noticeNo) {
		sqlSessionTemplate.update("content.updateNoticeByAdmin",noticeNo);
		
	}

	@Override
	public List<BoardVO> getAllNoticeList(String pageNo) {
		//System.out.println("DAO pageNo" + pageNo);
		return sqlSessionTemplate.selectList("content.getAllNoticeList",pageNo);
	}

	@Override
	public NoticeBoardVO getNoticeByNo(int boardNo) {
		return sqlSessionTemplate.selectOne("content.getNoticeByNo",boardNo);
	}

	@Override
	public int totalNoticeContent() {
		return sqlSessionTemplate.selectOne("content.totalNoticeContent");
	}
}
