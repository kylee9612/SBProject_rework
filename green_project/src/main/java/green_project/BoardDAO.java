package green_project;

import java.sql.Date;
import java.util.ArrayList;

import model.Board;

public class BoardDAO {
	/***********************************************************************************/

	// 담당 : 이인상

	/***********************************************************************************/
	
	private static BoardDAO instance = new BoardDAO();
	private DBManager dbm = new DBManager();
	private String path = "green_project.";
	
	private BoardDAO() {}
	
	public static BoardDAO getInstance() {
		return instance;
	}
	
	/*******************************************************/
	
	// Type : (Announcement / Question / Answer
	// 대소문자 구분
	// Code가 0 이 아닌경우 answer
	
	public boolean addBoard(String type,String id, String title, String contents, Date written, int code) {
		try {
			
			@SuppressWarnings("unchecked")
			Class <? extends Board> clazz = (Class<? extends Board>) Class.forName(path+type+"DTO");
			@SuppressWarnings("rawtypes")
			Class[]cArgs;
			Board board;
			int no = dbm.getBoardNo(type);
			if(code != 0) {
				cArgs = new Class[6];
				cArgs[0] = int.class;
				cArgs[1] = String.class;
				cArgs[2] = String.class;
				cArgs[3] = String.class;
				cArgs[4] = int.class;
				cArgs[5] = Date.class;
				board = clazz.getDeclaredConstructor(cArgs).newInstance(no,id,title,contents,code,written);
			}
			else {
				cArgs = new Class[5];
				cArgs[0] = int.class;
				cArgs[1] = String.class;
				cArgs[2] = String.class;
				cArgs[3] = String.class;
				cArgs[4] = Date.class;
				board = clazz.getDeclaredConstructor(cArgs).newInstance(no,id,title,contents,written);
			}
			return dbm.addBoard(type,board);
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}
	
	public ArrayList<Board> getBoardList(String type) {
		return dbm.getBoardList(type);
	}
	
	public ArrayList<Board> getBoardList(String type, int no){
		return dbm.getBoardList(type,no);
	}
	
	public ArrayList<Board> getBoardList(String type, Date today){
		return dbm.getBoardList(type,today);
	}
	
	public ArrayList<Board> getBoardList(String type, int limit, String standard, String ascOrDesc){
		return dbm.getBoardList(type, limit, standard, ascOrDesc);
	}
	
	public Board getBoard(String type,int no) {
		return dbm.getBoard(type, no);
	}
	
	public boolean updateBoard(Board board, String type , int no) {
		return dbm.updateBoard(board, type, no);
	}
	
	public boolean delteBoard(String type , int no) {
		return dbm.deleteBoard(type, no);
	}
	
	
	/*******************************************************/
	
	/*******************************************************/
}