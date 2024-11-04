package com.finalProject.util;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.text.DecimalFormat;
import java.util.Base64;
import java.util.Calendar;
import java.util.UUID;

import javax.imageio.ImageIO;

//import org.apache.commons.io.FileUtils;
import org.springframework.stereotype.Component;

@Component // �뒪�봽留� 而⑦뀒�씠�꼫�뿉寃� 媛앹껜瑜� 留뚮뱾�뼱 愿�由ы븯�룄濡�
public class FileProcess {

	public String makePath(String realPath) throws IOException {

		String[] ymd = makeCalentdarPath(realPath);
		makeDirectory(realPath, ymd);
		String saveFilePath = realPath + ymd[ymd.length - 1];
		
		return saveFilePath;
		// �뙆�씪�씠 �떎�젣 ���옣�릺�뒗 寃쎈줈: realPath + "�뀈/�썡/�씪"

		/*
		 * String[] ymd = makeCalentdarPath(realPath); String newFileName = ""; //
		 * BoardUpFilesVODTO result = null;
		 * 
		 * makeDirectory(realPath, ymd);
		 * 
		 * String saveFilePath = realPath + ymd[ymd.length - 1];
		 * 
		 * File fileToSave = new File(saveFilePath + File.separator + newFileName); //
		 * �떎�젣 ���옣 FileUtils.writeByteArrayToFile(fileToSave, upfile);
		 * 
		 * // �씠誘몄� �뙆�씪 -> �뜽�꽕�씪 String ext =
		 * originalFileName.substring(originalFileName.lastIndexOf(".") + 1); if
		 * (ImageMimeType.isImage(ext)) { //
		 * System.out.println("�씠誘몄��엯�땲�떎... �뜽�꽕�씪�쓣 留뚮뱾寃좎뒿�땲�떎."); String thumbImgName =
		 * makeThumbNailImage(saveFilePath, newFileName);
		 * 
		 * System.out.println("thumbImgName: " + thumbImgName);
		 * 
		 * String base64Str = makeBase64String(saveFilePath + File.separator +
		 * thumbImgName);
		 * 
		 * System.out.println("Base64: " + base64Str);
		 * 
		 * result = BoardUpFilesVODTO.builder().ext(ext).newFileName(ymd[2] +
		 * File.separator + newFileName)
		 * .originFileName(originalFileName).size(fileSize).base64Img(base64Str)
		 * .thumbFileName(ymd[2] + File.separator + thumbImgName).build();
		 * 
		 * System.out.println("result: " + result);
		 * 
		 * } else { // �씠誘몄�媛� �븘�땶 寃쎌슦 result =
		 * BoardUpFilesVODTO.builder().ext(ext).newFileName(ymd[2] + File.separator +
		 * newFileName) .originFileName(originalFileName).size(fileSize).build(); }
		 * 
		 * return result;
		 */
	}

	private String[] makeCalentdarPath(String realPath) {
		// TODO Auto-generated method stub

		Calendar now = Calendar.getInstance();

		String year = File.separator + now.get(Calendar.YEAR) + "";
		String month = year + File.separator + new DecimalFormat("00").format(now.get(Calendar.MONTH) + 1);
		String date = month + File.separator + new DecimalFormat("00").format(now.get(Calendar.DATE));

		System.out.println("year: " + year);
		System.out.println("month: " + month);
		System.out.println("date: " + date);

		String[] ymd = { year, month, date };

		return ymd;
	}

	private void makeDirectory(String realPath, String[] ymd) {
		// �떎�젣 directory �깮�꽦
		System.out.println(new File(realPath + ymd[ymd.length - 1]).exists());

		if (!new File(realPath + ymd[ymd.length - 1]).exists()) {
			for (String path : ymd) {
				File tmp = new File(realPath + path);
				if (!tmp.exists()) {
					tmp.mkdir();
				}
			}
		}
	}

}
