package org.kosta.momentor;


import java.util.List;

import javax.annotation.Resource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.kosta.momentor.contents.model.CommunityBoardDAO;
import org.kosta.momentor.contents.model.CommunityBoardVO;
import org.kosta.momentor.contents.model.ExerciseBoardDAO;
import org.kosta.momentor.contents.model.ExerciseBoardService;
import org.kosta.momentor.contents.model.ExerciseBoardVO;
//github.com/colblade/Momentor-test.git
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations=("file:src/main/webapp/WEB-INF/spring/root-context.xml"))
public class TestJUnit {
	@Resource
	private CommunityBoardDAO exerciseBoardDAO;
	@Test
	public void test(){

		List<CommunityBoardVO> list = exerciseBoardDAO.getCommunityBoardListBestTop5ByRecommend();
		
		System.out.println(list);
	}
}
