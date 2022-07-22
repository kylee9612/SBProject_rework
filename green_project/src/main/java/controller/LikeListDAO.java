package controller;

import java.util.ArrayList;

import model.ItemDTO;
import model.LikeListDTO;

public class LikeListDAO {
	/***********************************************************************************/

	// 담당 : 이인상

	/***********************************************************************************/

	private static LikeListDAO instance = new LikeListDAO();
	
	
	private LikeListDAO() {}
	
	public static LikeListDAO getInstance() {
		return instance;
	}
	
	private DBManager dbm = new DBManager(); 
	
	/**********************************************************************************************/
	
	public boolean addLikeItem(String id,int code) {
		LikeListDTO like = new LikeListDTO(id, code);
		return dbm.addLikeList(like) && dbm.addLikeCount(code);
	}
	
	public boolean deleteLikeItem(String id,int code) {
		LikeListDTO like = new LikeListDTO(id, code);
		return dbm.deleteLikeList(like) && dbm.minusLikeCount(code);
	}
	
	public ArrayList<LikeListDTO> getLikeList(String id){
		return dbm.getLikeList(id);
	}
	
	public ArrayList<ItemDTO> getLikeListItem(String id){
		ArrayList <LikeListDTO> list=  dbm.getLikeList(id);
		ArrayList<ItemDTO> itemList = new ArrayList<ItemDTO>();
		for(LikeListDTO like : list) {
			ItemDTO item = dbm.getItem(like.getCode());
			itemList.add(item);
		}
		return itemList;
	}
	
	public boolean isLiked(String id, int code) {
		ArrayList<LikeListDTO> list = getLikeList(id);
		for(LikeListDTO i : list) {
			if(i.getCode()==code)
				return true;
		}
		return false;
	}
	
	
	/**********************************************************************************************/
}
