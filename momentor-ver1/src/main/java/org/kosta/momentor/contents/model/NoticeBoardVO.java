package org.kosta.momentor.contents.model;

import org.kosta.momentor.member.model.MomentorMemberVO;

public class NoticeBoardVO extends BoardVO {

	public NoticeBoardVO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public NoticeBoardVO(int boardNo, MomentorMemberVO momentorMemberVO,
			String boardTitle, String boardWdate, String boardContent,
			int ranking) {
		super(boardNo, momentorMemberVO, boardTitle, boardWdate, boardContent, ranking);
		// TODO Auto-generated constructor stub
	}


}
