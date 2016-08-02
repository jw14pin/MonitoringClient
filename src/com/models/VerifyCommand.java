package com.models;

public class VerifyCommand implements Command {
	private String command = "verify";
	private String phrase;

	public void setCommand(String command) {
		this.command = command;
	}
	
	
	
	public String getCommand() {
		return command;
	}



	public String getPhrase() {
		return phrase;
	}

	public void setPhrase(String phrase) {
		this.phrase = phrase;
	}
	
}
