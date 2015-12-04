package org.kosta.momentor.planner.model;

import java.util.List;

import javax.annotation.Resource;

import org.kosta.momentor.cart.model.CartDAO;
import org.kosta.momentor.cart.model.CartVO;
import org.springframework.stereotype.Service;

@Service
public class PlannerServiceImpl implements PlannerService {
	@Resource
	private PlannerDAO plannerDAO;
	@Resource
	private CartDAO cartDAO;

	@Override
	public void registerExerciseInPlanner(PlannerVO pvo) {
	plannerDAO.registerExerciseInPlanner(pvo);
		
	}

	@Override
	public void updateTargetSetInPlanner(PlannerVO pvo) {
		// TODO Auto-generated method stub
		plannerDAO.updateTargetSetInPlanner(pvo);
	}
	
	@Override
	public String getPlannerContentByDate(PlannerVO pvo){
		String plannerContent = "";
		// 코멘트가 미등록되어있는 상태일 경우에는 null이 반환되므로
		// NullPointerException 발생시에는 공백문자를 반환한다.
		try{
			PlannerVO planvo = plannerDAO.getPlannerContentByDate(pvo);
			plannerContent = planvo.getPlannerContent();
		} catch(NullPointerException e) {
			return plannerContent;
		}
		return plannerContent;
	}

	@Override
	public int updateCommentInPlanner(PlannerVO pvo) {
		return plannerDAO.updateCommentInPlanner(pvo);
	}
	
	@Override
	public void registerCommentInPlanner(PlannerVO pvo) {
		plannerDAO.registerCommentInPlanner(pvo);
	}

	@Override
	public void updateAchievementInPlanner(PlannerVO pvo) {
		// TODO Auto-generated method stub
		plannerDAO.updateAchievementInPlanner(pvo);
	}

	@Override
	public List<PlannerVO> getPlannerList(String id) {
		// TODO Auto-generated method stub
		return plannerDAO.getPlannerList(id);
	}

	@Override
	public PlannerVO getPlannerByDate(PlannerVO pvo) {
		// TODO Auto-generated method stub
		return plannerDAO.getPlannerByDate(pvo);
	}

	@Override
	public void deleteExerciseInPlanner(PlannerVO pvo) {
		// TODO Auto-generated method stub
		plannerDAO.deleteExerciseInPlanner(pvo);
	}

	@Override
	public List<PlannerVO> getPlannerListByDate(PlannerVO pvo) {
		List<PlannerVO> pListByDate = plannerDAO.getPlannerListByDate(pvo);
		List<PlannerVO> allpList = plannerDAO.getPlannerList(pvo.getMomentorMemberVO().getMemberId());
		float achievementPercentMonth = 0;
		float achievementPercentDay = 0;
		float sumAchievementSetValMonth = 0;
		float sumAchievementSetValDay = 0;
		float sumTargetSetValMonth = 0;
		float sumTargetSetValDay = 0;
		// 전체 플래너 목록과 해당일 플래너 목록이 비어있지 않을 때
		if(allpList.size() != 0 && pListByDate.size() != 0){
			for(int i=0; i<allpList.size(); i++){
				float achievementSetVal = allpList.get(i).getAchievement();
				float targetSetVal = allpList.get(i).getTargetSet();
				// 당월 달성도 계산
				String inputMonth = pvo.getPlannerDate().substring(0, 7); // 매개변수로로 입력된 plannerDate에서 년월만 추출
				String outputMonth = allpList.get(i).getPlannerDate().substring(0, 7); // DB에서 반환된 plannerDate에서 년월만 추출
				if(inputMonth.equals(outputMonth)){ // 입력된 년월과 반환된 년월이 일치할 때
					sumAchievementSetValMonth += achievementSetVal; 
					sumTargetSetValMonth += targetSetVal;
				}
			}
			// 해당 월의 달성도를 계산하여 리스트의 첫번째(0) 객체의 achievementPercentMonth에 넣어준다.
			// achievementPercentMonth는 DB에 저장되지 않기 때문에 첫번째 객체에 임의로 넣어 전달하도록 했다.
			achievementPercentMonth = sumAchievementSetValMonth/sumTargetSetValMonth*100;
			pListByDate.get(0).setAchievementPercentMonth((int) achievementPercentMonth);
		}
		// 해당일 플래너 목록이 비어있지 않을 때
		if(pListByDate.size() != 0){
			for(int i=0; i<pListByDate.size(); i++){
				float achievementSetVal = pListByDate.get(i).getAchievement();
				float targetSetVal = pListByDate.get(i).getTargetSet();
				float achievementPercent = achievementSetVal/targetSetVal*100;
				// 해당일의 각각의 운동에 대한 달성도를 계산하여 achievementPercent에 set 한다.
				pListByDate.get(i).setAchievementPercent((int) achievementPercent);
				// 당일 달성도 계산
				if(pListByDate.get(i).getPlannerDate().equals(pvo.getPlannerDate())){
					sumAchievementSetValDay += achievementSetVal;
					sumTargetSetValDay += targetSetVal;
				}
			}
			// 해당 일의 달성도를 계산하여 리스트의 첫번째(0) 객체의 achievementPercentDay에 넣어준다.
			// achievementPercentDay는 DB에 저장되지 않기 때문에 첫번째 객체에 임의로 넣어 전달하도록 했다.
			achievementPercentDay = sumAchievementSetValDay/sumTargetSetValDay*100;
			pListByDate.get(0).setAchievementPercentDay((int) achievementPercentDay);
		}
		return pListByDate;
	}
	
	@Override
	public List<CartVO> getCartList(String id) {
		return cartDAO.getCartList(id);
	}
	
	@Override
	public void deleteExcerciseInCart(CartVO cvo) {
		cartDAO.deleteExcerciseInCart(cvo);
	}
}
