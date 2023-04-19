package kr.or.ddit.service;

import java.util.Random;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Component;

import kr.or.ddit.vo.EmpVO;

@Component
public class MailSendService {
	@Autowired
	private JavaMailSenderImpl mailSender;
	private int authNumber; 
	// 난수 발생
	
		public void makeRandomNumber() {
			// 난수의 범위 111111 ~ 999999 (6자리 난수)
			Random r = new Random();
			int checkNum = r.nextInt(888888) + 111111;
			System.out.println("인증번호 : " + checkNum);
			authNumber = checkNum;
		}
		
		// 회원가입 이메일 인증 양식 
		public String joinEmail(String email) {
			makeRandomNumber();
			String setFrom = "gru_office01@naver.com"; // email-config에 설정한 자신의 이메일 주소를 입력 
			String toMail = email;
			String title = "[그루오피스] 회원 가입 인증"; // 이메일 제목 
			String content = 
					"<h3>[그루오피스] 회원 가입 인증 이메일 입니다.</h3>" + 
	                "<br><br>" + 
				    "인증 번호는 " + authNumber + "입니다." + 
				    "<br>" + 
				    "해당 인증번호를 인증번호 확인란에 기입하여 주세요."; //이메일 내용 삽입
			mailSend(setFrom, toMail, title, content);
			return Integer.toString(authNumber);
		}
		
		// 이메일로 아이디 찾기 양식 
//		public int findId(EmpVO empVO) {
//			String setFrom = "gru_office01@naver.com"; // email-config에 설정한 자신의 이메일 주소를 입력 
//			String toMail = empVO.getEmpEmlAddr();
//			String title = "[그루오피스] 아이디 찾기"; // 이메일 제목 
//			String content = 
//					"<h3>[그루오피스] 아이디 찾기 이메일 입니다.</h3>" + 	
//							"<br><br>" + 
//							"찾으시는 아이디는 <b>" + empVO.getEmpNo() + "</b> 입니다." + 
//							"<br>";
//			mailSend(setFrom, toMail, title, content);
//			return 1;
//		}
		// 이메일로  비밀번호 찾기 양식 
		public String findPw(EmpVO empVO) {
			makeRandomNumber();
			String setFrom = "gru_office01@naver.com"; // email-config에 설정한 자신의 이메일 주소를 입력 
			String toMail = empVO.getEmpEmlAddr();
			String title = "[그루오피스] 임시 비밀번호 발급"; // 이메일 제목 
			String content = 
					"<h3>[그루오피스] 임시 비밀번호 발급</h3>" + 	
							empVO.getEmpNm() + "님! <br><br>" + 
							"발급된 임시비밀번호는 <b>" + authNumber + "</b> 입니다.<br><br>" + 
							"로그인 후 임시 비밀번호를 변경하시길 바랍니다.<br>";
			mailSend(setFrom, toMail, title, content);
			return Integer.toString(authNumber);
		}
		
		//이메일 전송 메소드
		public void mailSend(String setFrom, String toMail, String title, String content) { 
			MimeMessage message = mailSender.createMimeMessage();
			
			try {
				MimeMessageHelper helper = new MimeMessageHelper(message,true,"utf-8");
				helper.setFrom(setFrom);
				helper.setTo(toMail);
				helper.setSubject(title);
				// true 전달 > html 형식으로 전송 , 작성하지 않으면 단순 텍스트로 전달.
				helper.setText(content,true);
				mailSender.send(message);
			} catch (MessagingException e) {
				e.printStackTrace();
			}
		}
		
	
}