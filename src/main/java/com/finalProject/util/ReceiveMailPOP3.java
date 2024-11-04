package com.finalProject.util;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.security.NoSuchProviderException;
import java.util.Properties;

import javax.mail.Folder;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Store;

import org.springframework.stereotype.Component;

@Component // Spring 而⑦뀒�씠�꼫媛� �빐�떦 �겢�옒�뒪瑜� 鍮덉쑝濡� �벑濡�
public class ReceiveMailPOP3 {

	private String host;
	private String user;
	private String password;

	public void receiveMailPOP3(String phone) throws FileNotFoundException, IOException, MessagingException {

		Properties props = new Properties();
		// gmail.properties�뿉�꽌 host, user, password瑜� 諛쏆븘�샂
		readProperties();
		props.put("mail.pop3.host", host);
		props.put("mail.pop3.port", "995"); // POP3 �룷�듃(SSL)
		props.put("mail.pop3.ssl.enable", "true"); // SSL �궗�슜

		Session session = Session.getDefaultInstance(props);

		try {
			Store store = session.getStore("pop3");
			store.connect(user, password); // POP3 �꽌踰꾩뿉 �뿰寃�

			// �씠硫붿씪 �뤃�뜑 �뿴湲�
			Folder folder = store.getFolder("INBOX");
			folder.open(Folder.READ_ONLY); // �씫湲� �쟾�슜 紐⑤뱶濡� �뤃�뜑 �뿴湲�
			// �씠硫붿씪 硫붿꽭吏� 媛��졇�삤湲�
			Message[] messages = folder.getMessages();
			for (Message message : messages) {
				String tmpFrom = message.getFrom()[0].toString();
				String tmpSubject = message.getSubject();
//				System.out.println("Subject: " + message.getSubject());
				// 01091647735 <01091647735@vmms.nate.com> �뿉�꽌 <@�궗�씠�쓽 媛� 異붿텧�븯湲�
				String tmpPhone = tmpFrom.substring(tmpFrom.indexOf("<")+1, tmpFrom.indexOf("@"));
				System.out.println("Content: "+ tmpSubject);
				System.out.println("phone: "+ tmpPhone);
				System.out.println("---------------------------------");
				if(phone.equals(tmpPhone)) {
					System.out.println("�씤利앸찓�씪 諛쒓껄");
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

		// �빐�떦 寃쎈줈�쓽 properties瑜� 諛쏆쓬.
		prop.load(new FileReader("D:\\my\\coding\\Flnal_2team\\final_project\\src\\main\\resources\\gmail.properties"));
		;
		// �븘�슂�븳 媛� ���옣
		this.host = prop.get("host") + "";
		this.user = prop.get("user") + "";
		this.password = prop.get("password") + "";
	}

}
