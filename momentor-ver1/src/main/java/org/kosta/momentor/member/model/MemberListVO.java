package org.kosta.momentor.member.model;


import java.util.ArrayList;

import org.kosta.momentor.contents.model.PagingBean;

/**
 * 게시물 리스트 정보와 페이징 정보를 가지고 있는 클래스 
 * @author inst
 *
 */
public class MemberListVO {
	private ArrayList<MomentorMemberPhysicalVO> list;
	private PagingBean pagingBean;
	public MemberListVO() {
		super();
	}
	public MemberListVO(ArrayList<MomentorMemberPhysicalVO> list,
			PagingBean pagingBean) {
		super();
		this.list = list;
		this.pagingBean = pagingBean;
	}
	public ArrayList<MomentorMemberPhysicalVO> getList() {
		return list;
	}
	public void setList(ArrayList<MomentorMemberPhysicalVO> list) {
		this.list = list;
	}
	public PagingBean getPagingBean() {
		return pagingBean;
	}
	public void setPagingBean(PagingBean pagingBean) {
		this.pagingBean = pagingBean;
	}
	@Override
	public String toString() {
		return "ListVO [list=" + list + ", pagingBean=" + pagingBean + "]";
	}
}
