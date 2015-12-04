package org.kosta.momentor.member.model;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.annotation.Resource;
import javax.mail.MessagingException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.kosta.momentor.contents.model.ListVO;
import org.kosta.momentor.contents.model.PagingBean;
import org.kosta.momentor.contents.model.ReListVO;
import org.kosta.momentor.contents.model.ReplyVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.MailException;
import org.springframework.mail.javamail.JavaMailSender;
//github.com/colblade/Momentor-test.git
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class MomentorMemberServiceImpl implements MomentorMemberService {
	
	@Resource
	private MomentorMemberDAO momentorMemberDAO;

	@Override
	public MomentorMemberVO managerFindMemberById(String id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public MomentorMemberVO managerFindMemberByNickName(String nickName) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<MomentorMemberVO> managerFindMemberByAddress(String address) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<MomentorMemberVO> managerFindMemberByName(String name) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public MomentorMemberPhysicalVO login(MomentorMemberVO vo) {
		return momentorMemberDAO.login(vo);
	}

	@Override
	public void updateMember(MomentorMemberVO vo) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void registerMember(MomentorMemberVO vo, String date, String memberEmail, String memberEmail2,String memberWeight,String memberHeight) {
		momentorMemberDAO.registerMember(vo);
		MomentorMemberPhysicalVO pnvo=new MomentorMemberPhysicalVO();
	    SimpleDateFormat mSimpleDateFormat = new SimpleDateFormat ( "yyyy", Locale.KOREA );
        Date currentTime = new Date ( );
        String mTime = mSimpleDateFormat.format ( currentTime );
        int mT=Integer.parseInt(mTime);
        int birthYear=Integer.parseInt(date.substring(0,4));
        int birthMonth=Integer.parseInt(date.substring(5,7));
        int birthDay=Integer.parseInt(date.substring(8,10));
        int age=mT-birthYear;
        int weight=Integer.parseInt(memberWeight);
        int height=Integer.parseInt(memberHeight);
        pnvo.setMemberWeight(weight);
        pnvo.setMemberHeight(height);
        double bmi=(double)weight/((double)height*(double)height)*(double)10000;
        double b = Math.round(bmi*100d) / 100d;
        vo.setBirthYear(birthYear);
        vo.setBirthMonth(birthMonth);
        vo.setBirthDay(birthDay);
        vo.setMemberEmail(memberEmail+"@"+memberEmail2);
        pnvo.setMomentorMemberVO(vo);
        if(mT<birthYear){
           pnvo.setAge(age+1);
        }else{
           pnvo.setAge(age+1);
        }
        pnvo.setBmi(b);
		momentorMemberDAO.registerPhysicalMember(pnvo);
	}

	@Override
	public MomentorMemberVO idCheck(MomentorMemberVO vo) {
		return momentorMemberDAO.idCheck(vo);
	}

	@Override
	public MomentorMemberVO passwordCheck(MomentorMemberVO vo){
		return momentorMemberDAO.passwordCheck(vo);
	}

	@Override
	public MomentorMemberVO findMemberById(String name, String email) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public MomentorMemberVO findMemberByPassword(String id, String name,
			String email) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public double bmi(MomentorMemberPhysicalVO vo) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public MomentorMemberVO deleteMemberByAdmin(String id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void deleteMemeber(MomentorMemberVO vo) {
		// TODO Auto-generated method stub
		
	}
	@Override
	public void registerPhysicalMember(MomentorMemberPhysicalVO pnvo) {
		momentorMemberDAO.registerPhysicalMember(pnvo);

		
	}

	@Override
	public ListVO getMyCommnunityBoardList(String memberId,String pageNo) {

		if(pageNo==null||pageNo.equals("")){
			pageNo = "1";
		}
		Map<String, String> map = new HashMap<String, String>();
		map.put("memberId", memberId);
		map.put("pageNo", pageNo);
		
	ListVO lvo = new ListVO();
	lvo.setList((ArrayList)momentorMemberDAO.getMyCommnunityBoardList(map));
		lvo.setPagingBean(new PagingBean(momentorMemberDAO.countAllMyCommnunityBoard(memberId), Integer.parseInt(pageNo)));
		return lvo;
	}

	@Override
	public ReListVO getMyReplyList(String memberId,String pageNo) {

		if(pageNo==null||pageNo.equals("")){
			pageNo = "1";
		}
		Map<String, String> map = new HashMap<String, String>();
		map.put("memberId", memberId);
		map.put("pageNo", pageNo);		
		ReListVO rvo = new ReListVO();
		rvo.setList((ArrayList<ReplyVO>)momentorMemberDAO.getMyReplyList(map));
		rvo.setPagingBean(new PagingBean(momentorMemberDAO.countAllMyReply(memberId), Integer.parseInt(pageNo)));
		return rvo;
	}
	
	@Autowired
    protected JavaMailSender  mailSender;
	@Override
	public void SendEmail(EmailVO email) throws Exception {
		MimeMessage msg = mailSender.createMimeMessage();
        try {
            msg.setSubject(email.getSubject());
            msg.setText(email.getContent());
            msg.setRecipients(MimeMessage.RecipientType.TO , InternetAddress.parse(email.getReceiver()));         
        }catch(MessagingException e) {
            System.out.println("MessagingException");
            e.printStackTrace();
        }
        try {
            mailSender.send(msg);
        }catch(MailException e) {
            System.out.println("MailException발생");
            e.printStackTrace();
        }
	}

	   @Override
	   public String nickNameOverlappingCheck(String nickName) {
	      int count=momentorMemberDAO.nickNameOverlappingCheck(nickName);
	      return (count==0) ? "ok":"fail"; 
	   }
	   @Override
	   public String idOverlappingCheck(String id) {
	      int count=momentorMemberDAO.idOverlappingCheck(id);
	      return (count==0) ? "ok":"fail"; 
	   }
	   
	   
	   @Override
		public String myPasswordCheck(String password, String memberId) {
			MomentorMemberPhysicalVO mpvo = momentorMemberDAO.myPageMemberInfo(memberId);
			System.out.println("서비스"+password);
			int passwordCheck= momentorMemberDAO.myPasswordCheck(password);
			System.out.println("passwordCheck : "+passwordCheck);
			System.out.println("mpvoPass" + mpvo.getMomentorMemberVO().getMemberPassword());
			return (passwordCheck!=0&&password.equals(mpvo.getMomentorMemberVO().getMemberPassword())) ? "ok":"fail"; 
		}
		public MomentorMemberPhysicalVO myPageMemberInfo(String memberId) {
			return momentorMemberDAO.myPageMemberInfo(memberId);
		}

		@Transactional
		@Override
		public String updateMember(MomentorMemberVO vo, MomentorMemberPhysicalVO pnvo) {
			System.out.println("service updateMember : vo?" + vo);
			System.out.println("service updateMember : pnvo?" + pnvo);
			momentorMemberDAO.updateMember(vo);
			momentorMemberDAO.updateMemberPhysical(pnvo);
			return "myInfoUpdate";
		}
		
		@Transactional
		@Override
		public String deleteMemeber(String memberId) {
			momentorMemberDAO.myPageDeleteMemberPhysicalInfo(memberId);
			momentorMemberDAO.myPageDeleteMemberInfo(memberId);
			return "myInfoDelete";
		}
}
