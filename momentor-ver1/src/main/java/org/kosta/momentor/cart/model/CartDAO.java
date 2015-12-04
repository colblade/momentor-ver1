package org.kosta.momentor.cart.model;

import java.util.List;

public interface CartDAO {
	//운동을 카트에 등록
	 public void registerExerciseInCart(CartVO cvo);
	//운동을 카트에 삭제
	public void deleteExcerciseInCart(CartVO cvo);
	//찜한 운동리스트 불러오기
	public List<CartVO> getCartList(String id);
	
	//찜하려는 운동리스트가 있는지 없는지 확인하는 메소드
	public int checkExercise(CartVO cvo);
}