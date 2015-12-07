package org.kosta.momentor.contents.model;

import java.util.List;
import java.util.Map;

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
	public void updateRecommend(Map<String, Integer> map) {
			sqlSessionTemplate.update("content.updateRecommend", map);
			
	}

	@Override
	public void updateNotRecommend(Map<String, Integer> map) {
		sqlSessionTemplate.update("content.updateNotRecommend", map);
		
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
	   
	   @Override
		public Map<String, String> getRecommendInfoByMemberId(Map<String, String> map) {
			
			//System.out.println("Dao상에서 memberId와 boardNo의 값 : "+ map);
		Map<String, String> res = sqlSessionTemplate.selectOne("content.getRecommendInfoByMemberId", map);
		//System.out.println("res: "+res);
			return res;
		}

		@Override
		public int updateRecommendInfo(Map<String, String> map) {
		return	sqlSessionTemplate.update("content.updateRecommendInfo", map);
			
		}


		@Override
		public void insertRecommendInfo(Map<String, String> map) {
			sqlSessionTemplate.update("content.insertRecommendInfo", map);
			
		}

		@Override
		public int countRecommend(int boardNo) {
			// TODO Auto-generated method stub
			return sqlSessionTemplate.selectOne("content.countRecommend", boardNo);
		}

		@Override
		public int countNotRecommend(int boardNo) {
			// TODO Auto-generated method stub
			return sqlSessionTemplate.selectOne("content.countNotRecommend", boardNo);
		}
	   
}
