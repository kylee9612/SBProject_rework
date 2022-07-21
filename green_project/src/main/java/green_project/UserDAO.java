package green_project;

import java.util.ArrayList;

public class UserDAO {
	/***********************************************************************************/

	// 담당 : 이인상

	/***********************************************************************************/
	private static UserDAO instance = new UserDAO();
	
	private UserDAO() {}
	
	public static UserDAO getInstance() {
		return instance;
	}
	private static String log;
	private int auth;
	private DBManager dbm = new DBManager();
	
	/**********************************************************************************************/
	
	public String getLog() {
		return log;
	}
	
	public void setLog(String log) {
		UserDAO.log = log; 
	}
	
	public UserDTO getUser(String id) {
		return dbm.getUser(id);
	}

	public boolean logIn(String id, String pw) {
		auth = dbm.logInUser(id, pw);
		if(auth != -1) {
			log = id;
			return true;
		}
		else
			return false;
	}
	
	public boolean logOut() {
		if(log != null){
			auth = -1;
			log = null;
			return true;
		}
		else
			return false;
	}
	
	public boolean addUser(UserDTO user) {
		return dbm.addUser(user);
	}

	public boolean checkDupId(String id) {
		return dbm.checkDupId(id);
	}
	
	public int getAuth(String id) {
		return dbm.getUser(id).getAuthority();
	}
	
	public String getUserId(String name, String mobile) {
		return dbm.getUserId(name, mobile);
	}
	public String getUserPw(String id,String name, String mobile) {
		return dbm.getUserPw(id,name, mobile);
	}

	public ArrayList<UserDTO> getUserList(){
		return dbm.getUserList();
	}
	
	public boolean updateUserInfo(UserDTO user) {
		return dbm.updateUserInfo(user);
	}

	public boolean deleteUser(UserDTO user) {
		return dbm.deleteUser(user);
	}

}
