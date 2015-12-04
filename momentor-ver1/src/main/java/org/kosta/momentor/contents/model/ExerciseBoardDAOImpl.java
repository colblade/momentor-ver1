package org.kosta.momentor.contents.model;

import java.util.List;

import javax.annotation.Resource;

import org.kosta.momentor.cart.model.ExerciseVO;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;
@Repository
public class ExerciseBoardDAOImpl implements ExerciseBoardDAO {
	@Resource
	private SqlSessionTemplate sqlSessionTemplate;

	@Override
	public void postingExerciseByAdmin(ExerciseBoardVO evo) {
		 sqlSessionTemplate.insert("content.postingExerciseByAdmin", evo);
	}

	@Override
	public void deleteExerciseByAdmin(String exerciseName) {
		sqlSessionTemplate.delete("content.deleteExerciseByAdmin", exerciseName);
	}

	@Override
	public void updateExerciseByAdmin(ExerciseVO evo) {
		sqlSessionTemplate.update("content.updateExerciseByAdmin", evo);
		
	}

/*	@Override
	public ReplyVO postingReply(ReplyVO rvo) {
		// TODO Auto-generated method stub
		return null;
	}*/

	@Override
	public void deleteReply(int mboardNo) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void updateReply(int mboardNo) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public List<BoardVO> getExerciseBoardList(String pageNo) {
		List<BoardVO> list = sqlSessionTemplate.selectList("content.getExerciseBoardList", pageNo);
		
		return list;
		
	}

	@Override
	public int countAllExerciseBoard() {
		// TODO Auto-generated method stub
		return sqlSessionTemplate.selectOne("content.countAllExerciseBoard");
	}

	@Override
	public int checkExerciseByExerciseName(String exerciseName) {
		return  sqlSessionTemplate.selectOne("content.checkExerciseByExerciseName", exerciseName);
	}

	@Override
	public ExerciseBoardVO getExerciseByNo(int boardNo) {
		// TODO Auto-generated method stub
		return sqlSessionTemplate.selectOne("content.getExerciseByNo", boardNo);
	}

	@Override
	public void registerExercise(ExerciseVO evo) {
		sqlSessionTemplate.insert("content.registerExercise", evo);
	}

	@Override
	public void updateExerciseHits(int boardNo) {
		sqlSessionTemplate.insert("content.updateExerciseHits", boardNo);		
	}

	@Override
	public void deleteExerciseBoardByAdmin(int eboardNo) {
		sqlSessionTemplate.delete("content.deleteExerciseBoardByAdmin", eboardNo);
	}

	@Override
	public void updateExerciseBoardByAdmin(ExerciseBoardVO ebvo) {
			sqlSessionTemplate.update("content.updateExerciseBoardByAdmin", ebvo);
	}

	@Override
	public List<ExerciseBoardVO> getExerciseBoardListBestTop5ByHits() {
		
		return sqlSessionTemplate.selectList("content.getExerciseBoardListBestTop5ByHits");
		
	}

	
}
