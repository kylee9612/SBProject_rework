package model;

import java.sql.Date;

enum BoardType {
	Question, Answer, Announcement
}

public abstract class Board {
	/***********************************************************************************/

	// 담당 : 이인상

	/***********************************************************************************/
	
	private int no;
	private String id;
	private String title;
	private String contents;
	private Date written;
	
	public Board(int no, String id, String title, String contents,Date written) {
		this.no = no;
		this.id = id;
		this.title = title;
		this.contents = contents;
		this.written = written;
	}
	
	public Board(String title,String contents) {
		this.title=title;
		this.contents=contents;
	}
	
	public int getNo() {
		return no;
	}
	public String getId() {
		return id;
	}
	public String getTitle() {
		return title;
	}
	public String getContents() {
		return contents;
	}

	public Date getWritten() {
		return written;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public void setContents(String contents) {
		this.contents = contents;
	}
}
