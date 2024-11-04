package com.finalProject.util;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.net.PasswordAuthentication;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.springframework.stereotype.Component;

@Component // Spring 而⑦뀒�씠�꼫媛� �빐�떦 �겢�옒�뒪瑜� 鍮덉쑝濡� �벑濡�
public class SendMailUtil {

	private String host;
	private String user;
	private String password;

	public void sendMail(String to, String subject, String content) throws IOException, MessagingException {
		// Properties �꽕�젙
		Properties props = new Properties();
		readProperties();

		props.put("mail.smtp.host", host);
		props.put("mail.smtp.port", "587"); // TLS �룷�듃
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.starttls.enable", "true"); // TLS �궗�슜

		// �꽭�뀡 �깮�꽦
		Session session = Session.getInstance(props, new javax.mail.Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(user, password);
			}
		});

		// 硫붿떆吏� �옉�꽦
		MimeMessage message = new MimeMessage(session);
		message.setFrom(new InternetAddress(user)); // 蹂대궡�뒗 �궗�엺
		message.addRecipient(Message.RecipientType.TO, new InternetAddress(to)); // 諛쏅뒗 �궗�엺
		message.setSubject(subject); // �씠硫붿씪 �젣紐�
		message.setText(content); // �씠硫붿씪 蹂몃Ц

		// �씠硫붿씪 �쟾�넚
		Transport.send(message);
		System.out.println("�씠硫붿씪�씠 �꽦怨듭쟻�쑝濡� 諛쒖넚�릺�뿀�뒿�땲�떎: " + to);
	}

	private void readProperties() throws FileNotFoundException, IOException {
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
