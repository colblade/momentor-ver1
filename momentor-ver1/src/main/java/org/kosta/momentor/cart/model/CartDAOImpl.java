package org.kosta.momentor.cart.model;

import java.util.List;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;
@Repository
public class CartDAOImpl implements CartDAO {
	@Resource
	private SqlSessionTemplate sqlSessionTemplate;
	
	@Override
	public List<CartVO> getCartList(String id) {
		return sqlSessionTemplate.selectList("cart.getCarList", id);
	}
	
	@Override
	public void registerExerciseInCart(CartVO cvo) {
		sqlSessionTemplate.insert("cart.registerExerciseInCart", cvo);
	}

	@Override
	public void deleteExcerciseInCart(CartVO cvo) {
		sqlSessionTemplate.delete("cart.deleteExcerciseInCart", cvo);
	}
}