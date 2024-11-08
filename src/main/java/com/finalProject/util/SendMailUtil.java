package com.finalProject.util;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

import javax.mail.Folder;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.NoSuchProviderException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Store;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.springframework.stereotype.Component;

@Component // Spring 컨테이너가 해당 클래스를 빈으로 등록
public class SendMailUtil {

	private String host;
	private String user;
	private String password;

	public void sendMail(String to, String subject, String content) throws IOException, MessagingException {
		// Properties 설정
		Properties props = new Properties();
		readProperties();

		props.put("mail.smtp.host", host);
		props.put("mail.smtp.port", "587"); // TLS 포트
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.starttls.enable", "true"); // TLS 사용

		// 세션 생성
		Session session = Session.getInstance(props, new javax.mail.Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(user, password);
			}
		});

		// 메시지 작성
		MimeMessage message = new MimeMessage(session);
		message.setFrom(new InternetAddress(user)); // 보내는 사람
		message.addRecipient(Message.RecipientType.TO, new InternetAddress(to)); // 받는 사람
		message.setSubject(subject); // 이메일 제목
		message.setText(content); // 이메일 본문

		// 이메일 전송
		Transport.send(message);
		System.out.println("이메일이 성공적으로 발송되었습니다: " + to);
	}

	private void readProperties() throws FileNotFoundException, IOException {
		Properties prop = new Properties();

		// 해당 경로의 properties를 받음.
//		prop.load(new FileReader("D:\\my\\coding\\Flnal_2team\\final_project\\src\\main\\resources\\gmail.properties"));
		
		// 클래스패스에서 gmail.properties 파일을 읽음 src/main/resources
	    InputStream input = getClass().getClassLoader().getResourceAsStream("gmail.properties");
	    if (input == null) {
	        System.out.println("gmail.properties를 찾을수 없습니다.");
	    }
	    prop.load(input);
		
		// 필요한 값 저장
		this.host = prop.get("host") + "";
		this.user = prop.get("user") + "";
		this.password = prop.get("password") + "";
	}

}
