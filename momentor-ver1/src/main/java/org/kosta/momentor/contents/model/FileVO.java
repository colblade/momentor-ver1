package org.kosta.momentor.contents.model;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class FileVO {
	private String userInfo;
	private List<MultipartFile> file;
	public String getUserInfo() {
		return userInfo;
	}
	public void setUserInfo(String userInfo) {
		this.userInfo = userInfo;
	}
	public List<MultipartFile> getFile() {
		return file;
	}
	public void setFile(List<MultipartFile> file) {
		this.file = file;
	}
	@Override
	public String toString() {
		return "FileVO [userInfo=" + userInfo + ", file=" + file + "]";
	}

}
