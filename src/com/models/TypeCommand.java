package com.models;

public class TypeCommand implements Command {
	private String command = "type";
	private String word;
	private String characters;



	public void setCommand(String command) {
		this.command = command;
	}



	public String getWord() {
		return word;
	}



	public void setWord(String word) {
		this.word = word;
	}
	

	public String getCharacters() {
		return characters;
	}



	public void setCharacters(String characters) {
		this.characters = characters;
	}

}
