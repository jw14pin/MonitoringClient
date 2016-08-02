package com.models;

public class URLTest {
	private String url;
	private String verifyWord;
	private String cred;
	
	public URLTest(String url, String verifyWord, String cred) {
		this.url = url;
		this.verifyWord = verifyWord;
		this.cred = cred;
	}


	public String getCred() {
		return cred;
	}



	public void setCred(String cred) {
		this.cred = cred;
	}



	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getVerifyWord() {
		return verifyWord;
	}
	public void setVerifyWord(String verifyWord) {
		this.verifyWord = verifyWord;
	}
	
	
}
