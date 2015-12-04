package org.kosta.momentor.contents.model;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

@Service
public class CommunityBoardServiceImpl implements CommunityBoardService {
	@Resource
	private CommunityBoardDAO communityBoardDAO;

	@Override
	public CommunityBoardVO postingCommunity(CommunityBoardVO cvo) {
		return communityBoardDAO.postingCommunity(cvo); 
	}

	@Override
	public void deleteCommunity(int cboardNo) {
		communityBoardDAO.deleteCommunity(cboardNo);
	}

	@Override
	public void updateCommunity(CommunityBoardVO cvo) {
		communityBoardDAO.updateCommunity(cvo);
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
	   public ListVO getAllPostingList(String pageNo) {
			if(pageNo==null||pageNo=="") 
				pageNo="1";
			ArrayList<BoardVO> list=(ArrayList)communityBoardDAO.getAllPostingList(pageNo);
			int total=communityBoardDAO.totalContent();
			PagingBean paging=new PagingBean(total,Integer.parseInt(pageNo));
			ListVO lvo=new ListVO(list,paging);
	      return lvo;
	   }
	@Override
	public void updateHits(int boardNo) {
	
		communityBoardDAO.updateHits(boardNo);
		
	}

	@Override
	public List<ReplyVO> getReplyListByNo(int boardNo) {
		// TODO Auto-generated method stub
		return communityBoardDAO.getReplyListByNo(boardNo);
	}


	@Override
	public List<CommunityBoardVO> getCommunityBoardListBestTop5ByRecommend() {
		// TODO Auto-generated method stub
		return communityBoardDAO.getCommunityBoardListBestTop5ByRecommend();
	}
	   public CommunityBoardVO getCommunityByNo(int boardNo) {
		      //System.out.println("service:"+boardNo);
		      return communityBoardDAO.getCommunityByNo(boardNo);
		   }
}
