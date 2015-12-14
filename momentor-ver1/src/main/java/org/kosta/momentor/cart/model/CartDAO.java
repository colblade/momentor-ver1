package org.kosta.momentor.cart.model;

import java.util.List;

public interface CartDAO {
	public List<CartVO> getCartList(String id); // 찜바구니 리스트 출력
	public void registerExerciseInCart(CartVO cvo); // 찜바구니에 운동 담기
	public void deleteExcerciseInCart(CartVO cvo); // 찜바구니에서 운동 삭제
}