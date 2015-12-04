package org.kosta.momentor.contents.model;

import java.util.List;

import javax.annotation.Resource;

import org.kosta.momentor.member.model.MomentorMemberVO;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;
@Repository
public class CommunityBoardDAOImpl implements CommunityBoardDAO {
	@Resource
	private SqlSessionTemplate sqlSessionTemplate;

	@Override
	public CommunityBoardVO postingCommunity(CommunityBoardVO cvo) {
		sqlSessionTemplate.insert("content.postingCommunity",cvo);
		int no=sqlSessionTemplate.selectOne("content.getPostingNumber");
		cvo.setBoardNo(no);
		return cvo;
	}

	@Override
	public void deleteCommunity(int cboardNo) {
		sqlSessionTemplate.delete("content.deleteCommunity",cboardNo);
	}

	@Override
	public void updateCommunity(CommunityBoardVO cvo) {
		sqlSessionTemplate.update("content.updateCommunity",cvo);
	}

	@Override
	public ReplyVO postingReply(ReplyVO rvo) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void deleteReply(int cboardNo) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void updateReply(int cboardNo) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public List<CommunityBoardVO> findByCbTitle(String cbTitle) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<CommunityBoardVO> findByCbNickName(String nickName) {
		 
		return null;
	}

	@Override
	public void updateRecommend(int cbRecommend) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void updateNotRecommend(int cbNotRecommend) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public List<CommunityBoardVO> getAllPostingList() {
		List<CommunityBoardVO> list=sqlSessionTemplate.selectList("content.getAllPostingList");
		return list;
	}

	public CommunityBoardVO getCommunityByNo(int boardNo) {
		return sqlSessionTemplate.selectOne("content.getCommunityByNo", boardNo);
	}

	@Override
	public void updateHits(int boardNo) {
		sqlSessionTemplate.update("content.updateHits", boardNo);
		
	}

	@Override
	public List<ReplyVO> getReplyListByNo(int boardNo) {
		// TODO Auto-generated method stub
		return sqlSessionTemplate.selectList("content.getReplyListByNo", boardNo);
	}

	@Override
	public List<CommunityBoardVO> getCommunityBoardListBestTop5ByRecommend() {
		
		return sqlSessionTemplate.selectList("content.getCommunityBoardListBestTop5ByRecommend");
	}

	   @Override
	   public List<BoardVO> getAllPostingList(String pageNo) {
	      List<BoardVO> list=sqlSessionTemplate.selectList("content.getAllPostingList", pageNo);
	      //System.out.println(list);
	      return list;
	   }
	   @Override
		public int totalContent(){
			return sqlSessionTemplate.selectOne("content.totalContent");
		}
}
