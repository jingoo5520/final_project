package com.finalProject.util;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.Properties;

import javax.mail.Folder;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.NoSuchProviderException;
import javax.mail.Session;
import javax.mail.Store;

import org.springframework.stereotype.Component;

@Component // Spring 컨테이너가 해당 클래스를 빈으로 등록
public class ReceiveMailPOP3 {

	private String host;
	private String user;
	private String password;

	public void receiveMailPOP3(String phone) throws FileNotFoundException, IOException, MessagingException {

		Properties props = new Properties();
		// gmail.properties에서 host, user, password를 받아옴
		readProperties();
		props.put("mail.pop3.host", host);
		props.put("mail.pop3.port", "995"); // POP3 포트(SSL)
		props.put("mail.pop3.ssl.enable", "true"); // SSL 사용

		Session session = Session.getDefaultInstance(props);

		try {
			Store store = session.getStore("pop3");
			store.connect(user, password); // POP3 서버에 연결

			// 이메일 폴더 열기
			Folder folder = store.getFolder("INBOX");
			folder.open(Folder.READ_ONLY); // 읽기 전용 모드로 폴더 열기
			// 이메일 메세지 가져오기
			Message[] messages = folder.getMessages();
			for (Message message : messages) {
				String tmpFrom = message.getFrom()[0].toString();
				String tmpSubject = message.getSubject();
//				System.out.println("Subject: " + message.getSubject());
				// 01091647735 <01091647735@vmms.nate.com> 에서 <@사이의 값 추출하기
				String tmpPhone = tmpFrom.substring(tmpFrom.indexOf("<")+1, tmpFrom.indexOf("@"));
				System.out.println("Content: "+ tmpSubject);
				System.out.println("phone: "+ tmpPhone);
				System.out.println("---------------------------------");
				if(phone.equals(tmpPhone)) {
					System.out.println("인증메일 발견");
				}
			}

			folder.close(false);
			store.close();

		} catch (NoSuchProviderException e) {
			e.printStackTrace();
		}

	}

	public void readProperties() throws FileNotFoundException, IOException {
		Properties prop = new Properties();

		// 해당 경로의 properties를 받음.
		prop.load(new FileReader("D:\\my\\coding\\Flnal_2team\\final_project\\src\\main\\resources\\gmail.properties"));
		;
		// 필요한 값 저장
		this.host = prop.get("host") + "";
		this.user = prop.get("user") + "";
		this.password = prop.get("password") + "";
	}

}
