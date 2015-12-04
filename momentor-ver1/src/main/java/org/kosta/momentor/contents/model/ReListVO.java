package org.kosta.momentor.contents.model;

import java.util.ArrayList;
import java.util.List;

public class ReListVO {
	private ArrayList<ReplyVO> list;
	private PagingBean pagingBean;
	public ReListVO() {
		super();
	}
	public ReListVO(ArrayList<ReplyVO> list, PagingBean pagingBean) {
		super();
		this.list = list;
		this.pagingBean = pagingBean;
	}
	public List<ReplyVO> getList() {
		return list;
	}
	public void setList(ArrayList<ReplyVO> list) {
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
