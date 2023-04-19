package kr.or.ddit.controller;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;

public class FileController {

	/** 현재일자의 연/월/일을 기준으로 폴더 생성하는 메서드
	 * @return
	 */
	public static String getFolder() {
		//2023-01-27 형식(format) 지정
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

		Date date = new Date();

		//2023-01-27
		String str = sdf.format(date);
		//단순 날짜 문자를 File객체의 폴더타입으로 바꾸기
		//\\2023\\01\\27
		return str.replace("-", File.separator);
	}




}
