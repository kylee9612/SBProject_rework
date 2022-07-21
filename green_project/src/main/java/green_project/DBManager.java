package green_project;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Random;

import model.Board;

public class DBManager {
	private final String url = "jdbc:mysql://database-1.c5bicjnwjty2.ap-northeast-2.rds.amazonaws.com:3306/sb?serverTimezon=UTC"; // SQL URL LINK
	private final String rootId = "admin"; // SQL ID
	private final String rootPw = "7rJxwvqQ1fpGYqvKxssn"; // SQL PW
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	private Random ran = new Random();
	private String path = "green_project.";

	/***********************************************************************************/

	// 담당 : 이인상

	/*********************************** User *****************************************/

	public boolean addUser(UserDTO user) {
		String sql = String.format("insert into users values('%s','%s','%s',%d,'%s','%s',%d,%d)", user.getId(),
				user.getPw(), user.getName(), user.getAge(), user.getMobile(), user.getEmail(), user.getPoint(),
				user.getAuthority());
		if(!checkDupId(user.getId())) {
			return false;
		}
		else {
			return executeAddtion("User", sql);
		}
	}

	public boolean deleteUser(UserDTO user) {
		String[] delList = {"reservation","like_list","item","announcement","question","answer","users"};
		for(String i : delList) {
			String sql = String.format("delete from %s where id = '%s'",i, user.getId());			
			executeDeletion(String.format("%s to Delete User",i), sql);
		}
		return true;
	}

	public int logInUser(String id, String pw) {
		String sql = String.format("select authority from users where id = '%s' and pw = '%s'", id, pw);
		try {
			rs = executeSelect("LogIn", sql);
			if (rs.next()) {
				System.out.println("Login Suceess");
				int value = rs.getInt(1);
				closeConnection();
				return value;
			} else
				throw new SQLException();
		} catch (SQLException e) {
			e.printStackTrace();
			System.err.println("Login Failed");
			closeConnection();
			return -1;
		}
	}

	public UserDTO getUser(String id) {
		String sql = String.format("select * from users where id = '%s'", id);
		try {
			rs = executeSelect("User", sql);
			if (rs.next()) {
				String userid = rs.getString(1);
				String pw = rs.getString(2);
				String name = rs.getString(3);
				int age = rs.getInt(4);
				String mobile = rs.getString(5);
				String email = rs.getString(6);
				int point = rs.getInt(7);
				int auth = rs.getInt(8);
				UserDTO user = new UserDTO(userid, pw, name, age, mobile, email, point, auth);
				closeConnection();
				return user;
			} else
				throw new SQLException();
		} catch (SQLException e) {
			e.printStackTrace();
			System.err.println("Invalid User Id");
			closeConnection();
			return null;
		}
	}

	public String getUserId(String name, String mobile) {
		String sql = String.format("select id from users where name = '%s' and mobile = '%s'", name, mobile);
		try {
			rs = executeSelect("User ID", sql);
			if (rs.next()) {
				String value = rs.getString(1);
				closeConnection();
				return value;
			} else
				throw new SQLException();
		} catch (SQLException e) {
			e.printStackTrace();
			System.err.println("Getting ID Failed");
			closeConnection();
			return null;
		}
	}

	public String getUserPw(String id, String name, String mobile) {
		String sql = String.format("select pw from users where id = '%s' and name = '%s' and mobile = '%s' ", id, name,
				mobile);
		try {
			getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				String value = rs.getString(1);
				closeConnection();
				return value;
			} else
				throw new SQLException();
		} catch (SQLException e) {
			e.printStackTrace();
			System.err.println("Getting PW Failed");
			closeConnection();
			return null;
		}
	}

	public boolean joinUser(String id, String pw, String name, int age, String mobile, String email, int auth) {
		if (checkDupId(id)) {
			UserDTO user = new UserDTO(id, pw, name, age, mobile, email, age, auth);
			return addUser(user);
		} else
			return false;
	}

	public boolean checkDupId(String id) {
		String sql = String.format("select id from users where id = '%s'", id);
		try {
			getConnection();
			rs = executeSelect("ID Duplicate", sql);
			if (rs.next()) {
				System.err.println("중복된 ID");
				closeConnection();
				return false;
			} else {
				closeConnection();
				return true;
			}
		} catch (SQLException e) {
			closeConnection();
			return true;
		}
	}

	public ArrayList<UserDTO> getUserList() {
		String sql = String.format("select * from users");
		try {
			ArrayList<UserDTO> list = new ArrayList<>();
			rs = executeSelect("User List", sql);
			while (rs.next()) {
				String userid = rs.getString(1);
				String pw = rs.getString(2);
				String name = rs.getString(3);
				int age = rs.getInt(4);
				String mobile = rs.getString(5);
				String email = rs.getString(6);
				int point = rs.getInt(7);
				int auth = rs.getInt(8);
				UserDTO user = new UserDTO(userid, pw, name, age, mobile, email, point, auth);
				list.add(user);
			}
			closeConnection();
			return list;
		} catch (SQLException e) {
			e.printStackTrace();
			closeConnection();
			return null;
		}
	}

	public boolean updateUserInfo(UserDTO user) {
		String sql = String.format(
				"update users set pw = '%s', name = '%s', age = %d, mobile = '%s', email = '%s' where id = '%s'",
				user.getPw(), user.getName(), user.getAge(), user.getMobile(), user.getEmail(), user.getId());
			return executeUpdate("User Info", sql);
	}

	/********************************** Item *****************************************/

	public boolean addItem(ItemDTO item) {
		String sql = String.format("insert into item values ('%s','%s','%s',%d,%d,%d,'%s',%d,'%s','%s',%.2f,%d)",
				item.getId(), item.getName(), item.getAddress(), item.getCode(), item.getView_count(),
				item.getLike_count(), item.getCategory(), item.getPrice(), item.getThumbnail(), item.getContents(),
				item.getRate(), item.getMax_people());
		return executeAddtion("Item", sql);
	}

	public boolean deleteItem(ItemDTO item) {
		String sql = String.format("delete from item where code = %d", item.getCode());
		return executeDeletion("Item", sql);
	}

	public ItemDTO getItem(int code) {
		String sql = String.format("select * from item where code = %d", code);
		try {
			rs = executeSelect("Item ", sql);
			if (rs.next()) {
				String id = rs.getString(1);
				String name = rs.getString(2);
				String address = rs.getString(3);
				int dtoCode = rs.getInt(4);
				int viewCount = rs.getInt(5);
				int likeCount = rs.getInt(6);
				String category = rs.getString(7); 
				int price = rs.getInt(8);
				String thumbnail = rs.getString(9);
				String contents = rs.getString(10);
				float rate = rs.getFloat(11);
				int max_people = rs.getInt(12);
				ItemDTO item = new ItemDTO(id, name, address, dtoCode, viewCount, likeCount, category, price, thumbnail,
						contents, rate, max_people);
				closeConnection();
				return item;
			} else
				throw new SQLException();
		} catch (SQLException e) {
			e.printStackTrace();
			System.err.println("Getting Item Failed");
			closeConnection();
			return null;
		}
	}
	public ArrayList<ItemDTO> getItemList() {
		ArrayList<ItemDTO> list = new ArrayList<ItemDTO>();
		String sql = String.format("select code from item");
		try {
			ResultSet tempRs = executeSelect("Item List", sql);
			while (tempRs.next()) {
				list.add(getItem(tempRs.getInt(1)));
			}
			closeConnection();
			tempRs.close();
			return list;
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
	}

	public ArrayList<ItemDTO> getItemList(String id, String address) {
		ArrayList<ItemDTO> list = new ArrayList<ItemDTO>();
		String sql = String.format("select code from item where id = '%s' and address = '%s'", id, address);
		try {
			ResultSet tempRs = executeSelect("Item List", sql);
			while (tempRs.next()) {
				list.add(getItem(tempRs.getInt(1)));
			}
			closeConnection();
			tempRs.close();
			return list;
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
	}
	//park 오류나면 바로 지우겠습니다...
	public ArrayList<ItemDTO> getItemLists(String id) {
		ArrayList<ItemDTO> lists = new ArrayList<ItemDTO>();
		String sql = String.format("select * from item where id = '%s'",id);
		rs = executeSelect("Item List", sql);
		try {
			while (rs.next()) {
				id = rs.getString(1);
				String name = rs.getString(2);
				String address = rs.getString(3);
				int dtoCode = rs.getInt(4);
				int viewCount = rs.getInt(5);
				int likeCount = rs.getInt(6);
				String category = rs.getString(7); 
				int price = rs.getInt(8);
				String thumbnail = rs.getString(9);
				String contents = rs.getString(10);
				float rate = rs.getFloat(11);
				int max_people = rs.getInt(12);
				ItemDTO dto = new ItemDTO(id,name,address,dtoCode,viewCount,likeCount,category,price,thumbnail,contents,rate,max_people);
				lists.add(dto);
			}
			closeConnection();
			return lists;
		} catch (Exception e) {
			e.printStackTrace();
			System.err.println("Listing Reservation Failed");
			closeConnection();
			return null;
		}
		
	}

	public ArrayList<ItemDTO> getItemList(String address) {
		String add[] = address.split("/");

		ArrayList<ItemDTO> list = new ArrayList<ItemDTO>();
		String sql = "select code from item where address like '%" + add[0] + "%" + add[1] + "%'";

		if (add[1].equals("전체"))
			sql = "select code from item where address like '%" + add[0] + "%'";
		if (add[0].equals("전체"))
			sql = "select code from item";

		try {

			getConnection();
			pstmt = conn.prepareStatement(sql);
			System.out.println("DBM 겟아이템 받은 주소 : " + address);
			System.out.println(address);

			ResultSet tempRs = executeSelect("Item List", sql);
			while (tempRs.next()) {
				list.add(getItem(tempRs.getInt(1)));
			}
			closeConnection();
			tempRs.close();
			return list;
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
	}

	public ArrayList<ItemDTO> getBestViewItemList() {
		ArrayList<ItemDTO> list = new ArrayList<ItemDTO>();
		String sql = "select * from item order by view_count desc limit 10";
		ResultSet temprs = executeSelect("Best View Item", sql);
		try {
			while (temprs.next()) {
				list.add(getItem(temprs.getInt(4)));
			}
			closeConnection();
			temprs.close();
			return list;
		} catch (SQLException e) {
			
			e.printStackTrace();
			return null;
		}
	}

	public ArrayList<ItemDTO> getBestLikeItemList() {
		ArrayList<ItemDTO> list = new ArrayList<ItemDTO>();
		String sql = "select * from item order by like_count desc limit 10";
		ResultSet temprs = executeSelect("Best View Item", sql);
		try {
			while (temprs.next()) {
				list.add(getItem(temprs.getInt(4)));
			}
			closeConnection();
			temprs.close();
			return list;
		} catch (SQLException e) {
			e.printStackTrace();
			closeConnection();
			return null;
		}
	}

	public boolean addViewCount(int code) {
		String firstSQL = "select view_count from item where code = " + code;
		rs = executeSelect("View Count", firstSQL);
		try {
			if (rs.next()) {
				int original_view = rs.getInt(1);
				String sql = String.format("update item set view_count = %d where code = %d", original_view + 1, code);
				return executeUpdate("View Count", sql);
			} else
				throw new SQLException();
		} catch (SQLException e) {
			e.printStackTrace();
			closeConnection();
			return false;
		}
	}

	public boolean addLikeCount(int code) {

		String firstSQL = "select like_count from item where code = " + code;
		rs = executeSelect("Like Count", firstSQL);
		try {
			if (rs.next()) {
				int original_like = rs.getInt(1);
				String sql = String.format("update item set like_count = %d where code = %d", original_like + 1, code);
				return executeUpdate("Like Count", sql);
			} else
				throw new SQLException();
		} catch (SQLException e) {
			e.printStackTrace();
			closeConnection();
			return false;
		}
	}

	public boolean minusLikeCount(int code) {
		String firstSQL = "select like_count from item where code = " + code;
		rs = executeSelect("Like Count", firstSQL);
		try {
			if (rs.next()) {
				int original_like = rs.getInt(1);
				String sql = String.format("update item set like_count = %d where code = %d", original_like - 1, code);
				closeConnection();
				return executeUpdate("Like Count", sql);
			} else
				throw new SQLException();
		} catch (SQLException e) {
			e.printStackTrace();
			closeConnection();
			return false;
		}
	}

	public int getRanCode() {
		int ranNum = ran.nextInt(999999999) + 1;
		String sql = String.format("select code from item where code = %d", ranNum);
		try {
			getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = executeSelect("Random Code", sql);
			while (rs.next()) {
				ranNum = ran.nextInt(999999999) + 1;
				sql = String.format("select code from item where code = %d", ranNum);
				pstmt = conn.prepareStatement(sql);
				rs = executeSelect("Random Code", sql);
			}
			closeConnection();
			return ranNum;
		} catch (Exception e) {
			e.printStackTrace();
			closeConnection();
			return -1;
		}
	}

	/*********************************** Reservation *****************************************/

	public boolean addReservation(ReservationDTO rsrv) {
		String sql = String.format("insert into reservation values('%s','%s','%s',%d,'%s',%d,0,%d)", rsrv.getReserve_date(),
				rsrv.getCheckin_date(), rsrv.getCheckout_date(), rsrv.getPrice(), rsrv.getId(), rsrv.getCode(),getRandomReservationCode());
		return executeAddtion("Reservation", sql);
	}

	public boolean deleteReservation(ReservationDTO rsrv) {
		String sql = String.format("delete from reservation where reserve_code = %d", rsrv.getReservationCode());
		return executeDeletion("Reservation", sql);
	}
	
	public boolean deleteReservation(int reserve_code) {
		String sql = String.format("delete from reservation where reserve_code = %d", reserve_code);
		return executeDeletion("Reservation", sql);
	}

	public boolean updateReview(ReservationDTO rsrv) {
		String sql = String.format("Update reservation set review = %d", rsrv.getReview());
		executeAddtion("Reservation", sql);
		float rate = getRate(rsrv.getCode());
		String updateSQL = String.format("Update item set rate = %.2f", rate);
		return executeUpdate("Rate ", updateSQL);
	}

	public ReservationDTO getReservation(String id, int reserve_code) {
		String sql = String.format("select * from reservation where id = '%s' and reserve_code = %d", id, reserve_code);
		rs = executeSelect("Reservation ", sql);
		try {
			Date reserve_date = rs.getDate(1);
			Date checkin_date = rs.getDate(2);
			Date checkout_date = rs.getDate(3);
			int price = rs.getInt(4);
			int code = rs.getInt(6);
			int review = rs.getInt(7);
			ReservationDTO dto = new ReservationDTO(reserve_date, checkin_date, checkout_date, price, id, code, review,
					reserve_code);
			closeConnection();
			return dto;
		} catch (SQLException e) {
			e.printStackTrace();
			closeConnection();
			return null;
		}
	}
	
	public boolean validToReseve(int code, Date checkIn, Date checkOut) {
		String sql = String.format(
				"select reserve_code from reservation where (code = %d and checkIn_date between %s and %s) or (code = %d and checkOut_date between %s and %s)",
				code, checkIn, checkOut, code, checkIn, checkOut);
		try {
			getConnection();
			pstmt = conn.prepareStatement(sql);
			if (pstmt.execute()) {
				closeConnection();
				return false;
			}
			return true;
		} catch (SQLException e) {
			e.printStackTrace();
			closeConnection();
			return true;
		}
	}

	public int getRandomReservationCode() {
		int ranNum = ran.nextInt(999999999) + 1;
		String sql = String.format("select reserve_code from reservation where reservation_code = %d", ranNum);
		try {
			rs = executeSelect("Reservation Code", sql);
			while (rs.next()) {
				ranNum = ran.nextInt(999999999) + 1;
				sql = String.format("select reserve_code from reservation where reservation_code = %d", ranNum);
				rs = executeSelect("Reservation Code", sql);
			}
			closeConnection();
			return ranNum;
		} catch (Exception e) {
			e.printStackTrace();
			closeConnection();
			return -1;
		}
	}

	public ArrayList<ReservationDTO> getReservationList(String today) {
		ArrayList<ReservationDTO> list = new ArrayList<>();
		String range = getMonthRange(today);
		String sql = String.format("select * from reservation where reserve_date between %s and %s", today+"01",range);
		rs = executeSelect("Reservation ", sql);
		try {
			while (rs.next()) {
				Date reserve_date = rs.getDate(1);
				Date checkin_date = rs.getDate(2);
				Date checkout_date = rs.getDate(3);
				int price = rs.getInt(4);
				String id = rs.getString(5);
				int code = rs.getInt(6);
				int review = rs.getInt(7);
				int reserve_code = rs.getInt(8);
				ReservationDTO dto = new ReservationDTO(reserve_date, checkin_date, checkout_date, price, id, code,
						review, reserve_code);
				list.add(dto);
			}
			closeConnection();
			return list;
		} catch (Exception e) {
			e.printStackTrace();
			System.err.println("Listing Reservation Failed");
			closeConnection();
			return null;
		}
	} 
	//   park 오류나면 바로 지우겠습니다...
	public ArrayList<ReservationDTO> getReservationLists(String id) {
		ArrayList<ReservationDTO> lists = new ArrayList<>();
		String sql = String.format("select * from reservation where id ='"+id+"'");
		rs = executeSelect("Reservation ", sql);
		try {
			while (rs.next()) {
				Date reserve_date = rs.getDate(1);
				Date checkin_date = rs.getDate(2);
				Date checkout_date = rs.getDate(3);
				int price = rs.getInt(4);
				id = rs.getString(5);
				int code = rs.getInt(6);
				int review = rs.getInt(7);
				int reserve_code = rs.getInt(8);
				ReservationDTO dto = new ReservationDTO(reserve_date, checkin_date, checkout_date, price, id, code,
						review, reserve_code);
				lists.add(dto);
			}
			closeConnection();
			return lists;
		} catch (Exception e) {
			e.printStackTrace();
			System.err.println("Listing Reservation Failed");
			closeConnection();
			return null;
		}
	}//

	public int getReservationCount(String id) {
		String sql = String.format("select count(*) from reservation where id = '%s'", id);
		rs = executeSelect("Reservation Count", sql);
		try {
			if (rs.next()) {
				int value = rs.getInt(1);
				closeConnection();
				return value;
			} else
				return 0;
		} catch (SQLException e) {
			e.printStackTrace();
			closeConnection();
			return 0;
		}
	}
	
	//리뷰 리스트
	public ArrayList<ReservationDTO> getReviewList(int code) {
		ArrayList<ReservationDTO> lists = new ArrayList<>();
		String sql = String.format("select * from reservation where code ="+code);
		rs = executeSelect("Reservation ", sql);
		try {
			while (rs.next()) {
				Date reserve_date = rs.getDate(1);
				Date checkin_date = rs.getDate(2);
				Date checkout_date = rs.getDate(3);
				int price = rs.getInt(4);
				String id = rs.getString(5);
				int review = rs.getInt(7);
				int reserve_code = rs.getInt(8);
				ReservationDTO dto = new ReservationDTO(reserve_date, checkin_date, checkout_date, price, id, code,
						review, reserve_code);
				lists.add(dto);
			}
			closeConnection();
			return lists;
		} catch (Exception e) {
			e.printStackTrace();
			System.err.println("Listing Reservation Failed");
			closeConnection();
			return null;
		}
	}//
	

	/*********************************** Like List *****************************************/

	public boolean addLikeList(LikeListDTO like) {
		String sql = String.format("insert into like_list values('%s',%d)", like.getId(), like.getCode());
		return executeAddtion("Like_list", sql);
	}

	public boolean deleteLikeList(LikeListDTO like) {
		String sql = String.format("delete from like_list where id = '%s' and code = %d", like.getId(), like.getCode());
		return executeDeletion("Like_list", sql);
	}

	public ArrayList<LikeListDTO> getLikeList(String id) {
		String sql = String.format("select * from like_list where id = '%s'", id);
		ArrayList<LikeListDTO> list = new ArrayList<>();
		ResultSet tempRs = executeSelect("Like List", sql);
		try {
			while (tempRs.next()) {
				list.add(new LikeListDTO(tempRs.getString(1), tempRs.getInt(2)));
			}
			tempRs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		closeConnection();
		return list;
	}

	/*********************************** Board *****************************************/

	public boolean addBoard(String type, Board board) {
		String forSQL = type.toLowerCase();
		String sql;
		if (board instanceof AnswerDTO) {
			sql = String.format("insert into %s values (%d,'%s','%s','%s',%d,'%s')", forSQL, board.getNo(),
					board.getId(), board.getTitle(), board.getContents(), ((AnswerDTO) board).getCode(),
					board.getWritten());
		} else
			sql = String.format("insert into %s values (%d,'%s','%s','%s','%s')", forSQL, board.getNo(), board.getId(),
					board.getTitle(), board.getContents(), board.getWritten());
		return executeAddtion(type, sql);
	}

	public int getBoardNo(String type) {
		String forSQL = type.toLowerCase();
		String sql = String.format("select max(no) from %s", forSQL);
		rs = executeSelect(type, sql);
		try {
			if (rs.next()) {
				int value = rs.getInt(1)+1;
				closeConnection();
				return value;
			}
			else
				throw new SQLException();
		} catch (SQLException e) {
			closeConnection();
			return 1;
		}
	}

	//	Type : Announcement / Question
	public ArrayList<Board> getBoardList(String type) {
		String forSQL = type.toLowerCase();
		String sql = "select * from " + forSQL + " order by written desc";
		ArrayList<Board> list = new ArrayList<Board>();
		try {
			rs = executeSelect(type, sql);
			while (rs.next()) {
				int no = rs.getInt(1);
				String id = rs.getString(2);
				String title = rs.getString(3);
				String contents = rs.getString(4);
				Date date = rs.getDate(5);
				Date written = Date.valueOf(date.toString());

				//	Class Type 별 DTO 생성
				@SuppressWarnings("unchecked")
				Class<? extends Board> clazz = (Class<? extends Board>) Class.forName(path + type + "DTO");
				@SuppressWarnings("rawtypes")
				Class cArgs[] = new Class[5];

				cArgs[0] = int.class;
				cArgs[1] = String.class;
				cArgs[2] = String.class;
				cArgs[3] = String.class;
				cArgs[4] = Date.class;

				Board board = clazz.getDeclaredConstructor(cArgs).newInstance(no, id, title, contents, written);
				list.add(board);
			}
			return list;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	//	Type : Answer
	public ArrayList<Board> getBoardList(String type, int number) {
		String forSQL = type.toLowerCase();
		String sql = String.format("select * from %s where code = %d order by written desc", forSQL, number);
		ArrayList<Board> list = new ArrayList<Board>();
		try {
			rs = executeSelect(type, sql);
			while (rs.next()) {
				int no = rs.getInt(1);
				String id = rs.getString(2);
				String title = rs.getString(3);
				String contents = rs.getString(4);
				Date written = rs.getDate(6);

				//	Class Type 별 DTO 생성
				@SuppressWarnings("unchecked")
				Class<? extends Board> clazz = (Class<? extends Board>) Class.forName(path + type + "DTO");
				@SuppressWarnings("rawtypes")
				Class cArgs[] = new Class[6];

				cArgs[0] = int.class;
				cArgs[1] = String.class;
				cArgs[2] = String.class;
				cArgs[3] = String.class;
				cArgs[4] = int.class;
				cArgs[5] = Date.class;

				Board board = clazz.getDeclaredConstructor(cArgs).newInstance(no, id, title, contents, number, written);
				list.add(board);
			}
			closeConnection();
			return list;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	//	Type : Announcement / Question
	public ArrayList<Board> getBoardList(String type, Date today) {
		String forSQL = type.toLowerCase();
		String sql = "select * from " + forSQL + " where written = '" + today + "' order by no";
		ArrayList<Board> list = new ArrayList<Board>();
		try {
			rs = executeSelect(type, sql);
			while (rs.next()) {
				int no = rs.getInt(1);
				String id = rs.getString(2);
				String title = rs.getString(3);
				String contents = rs.getString(4);
				Date date = rs.getDate(5);
				Date written = Date.valueOf(date.toString());

				//	Class Type 별 DTO 생성
				@SuppressWarnings("unchecked")
				Class<? extends Board> clazz = (Class<? extends Board>) Class.forName(path + type + "DTO");
				@SuppressWarnings("rawtypes")
				Class cArgs[] = new Class[5];

				cArgs[0] = int.class;
				cArgs[1] = String.class;
				cArgs[2] = String.class;
				cArgs[3] = String.class;
				cArgs[4] = Date.class;

				Board board = clazz.getDeclaredConstructor(cArgs).newInstance(no, id, title, contents, written);
				list.add(board);
			}
			closeConnection();
			return list;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	public Board getBoard(String type, int no) {
		String forSQL = type.toLowerCase();
		String sql = String.format("select * from %s where no = %d order by no", forSQL, no);
		try {
			rs = executeSelect(type, sql);
			Board board = null;

			if (rs.next()) {
				//	Class Type 별 DTO 생성
				@SuppressWarnings("unchecked")
				Class<? extends Board> clazz = (Class<? extends Board>) Class.forName(path + type + "DTO");
				if (type.equals("Answer")) {
					@SuppressWarnings("rawtypes")
					Class cArgs[] = new Class[6];

					cArgs[0] = int.class;
					cArgs[1] = String.class;
					cArgs[2] = String.class;
					cArgs[3] = String.class;
					cArgs[4] = int.class;
					cArgs[5] = Date.class;

					String id = rs.getString(2);
					String title = rs.getString(3);
					String contents = rs.getString(4);
					int code = rs.getInt(5);
					Date written = rs.getDate(6);

					board = clazz.getDeclaredConstructor(cArgs).newInstance(no, id, title, contents, code, written);
				} else {
					@SuppressWarnings("rawtypes")
					Class cArgs[] = new Class[5];

					cArgs[0] = int.class;
					cArgs[1] = String.class;
					cArgs[2] = String.class;
					cArgs[3] = String.class;
					cArgs[4] = Date.class;

					String id = rs.getString(2);
					String title = rs.getString(3);
					String contents = rs.getString(4);
					Date written = rs.getDate(5);

					board = clazz.getDeclaredConstructor(cArgs).newInstance(no, id, title, contents, written);
				}
			}
			closeConnection();
			return board;
		} catch (Exception e) {
			e.printStackTrace();
			closeConnection();
			return null;
		}
	}

	//	Type : Announcement / Question
	//	index board 노출 용
	public ArrayList<Board> getBoardList(String type, int limit, String standard, String ascOrDesc) {
		String forSQL = type.toLowerCase();
		String sql = String.format("select * from %s order by %s %s limit %d", forSQL, standard, ascOrDesc, limit);
		ArrayList<Board> list = new ArrayList<Board>();
		System.out.println(sql);
		try {
			rs = executeSelect(type, sql);
			while (rs.next()) {
				int no = rs.getInt(1);
				String id = rs.getString(2);
				String title = rs.getString(3);
				String contents = rs.getString(4);
				Date date = rs.getDate(5);
				Date written = Date.valueOf(date.toString());
				
				//	Class Type 별 DTO 생성
				@SuppressWarnings("unchecked")
				Class<? extends Board> clazz = (Class<? extends Board>) Class.forName(path + type + "DTO");
				@SuppressWarnings("rawtypes")
				Class cArgs[] = new Class[5];
				
				cArgs[0] = int.class;
				cArgs[1] = String.class;
				cArgs[2] = String.class;
				cArgs[3] = String.class;
				cArgs[4] = Date.class;
				
				Board board = clazz.getDeclaredConstructor(cArgs).newInstance(no, id, title, contents, written);
				list.add(board);
			}
			closeConnection();
			return list;
		} catch (Exception e) {
			e.printStackTrace();
			closeConnection();
			return null;
		}
	}
	
	
//	Type : Announcement  게시글 가져오기
	public ArrayList<Board> getBoardList(String type, int startNum, int endNum) {
		String forSQL = type.toLowerCase();
		System.out.println(startNum);
		System.out.println(endNum);
		String sql=String.format("select * from announcement order by no desc limit %d,%d ",startNum,endNum);
		//String sql = "select * from " + forSQL + " order by written desc";
		ArrayList<Board> list = new ArrayList<Board>();
		try {
			rs = executeSelect(type, sql);
			while (rs.next()) {
				int no = rs.getInt(1);
				String id = rs.getString(2);
				String title = rs.getString(3);
				String contents = rs.getString(4);
				Date date = rs.getDate(5);
				Date written = Date.valueOf(date.toString());

				//	Class Type 별 DTO 생성
				@SuppressWarnings("unchecked")
				Class<? extends Board> clazz = (Class<? extends Board>) Class.forName(path + type + "DTO");
				@SuppressWarnings("rawtypes")
				Class cArgs[] = new Class[5];

				cArgs[0] = int.class;
				cArgs[1] = String.class;
				cArgs[2] = String.class;
				cArgs[3] = String.class;
				cArgs[4] = Date.class;

				Board board = clazz.getDeclaredConstructor(cArgs).newInstance(no, id, title, contents, written);
				list.add(board);
			}
			return list;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	//공지 게시글 카운트
	public int getNoticeCnt() {
		String sql = String.format("select count(*) from announcement");
		getConnection();
		try {
			pstmt = conn.prepareStatement(sql);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				int count=rs.getInt(1);
				return count;
			}
		} catch (Exception e) {
			// TODO: handle exception
		}
		
		return 0;
	}
	
	public boolean updateBoard(Board board, String type, int no) {
		String forSQL = type.toLowerCase();
		String sql = String.format("update %s set title = '%s', contents = '%s' where no = %d", forSQL,
				board.getTitle(), board.getContents(), no);
		return executeUpdate(type, sql);
	}

	public boolean deleteBoard(String type, int no) {
		String forSQL = type.toLowerCase();
		String sql = String.format("delete from %s where no = %d", forSQL, no);
		return executeDeletion(type, sql);
	}

	/***********************************************************************************/

	private void getConnection() {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection(url, rootId, rootPw);
		} catch (SQLException | ClassNotFoundException e) {
			e.printStackTrace();
			closeConnection();
			System.err.println("DB Connection Error");
		}
	}

	// 추가 메소드 통일
	private boolean executeAddtion(String type, String sql) {
		try {
			getConnection();
			pstmt = conn.prepareStatement(sql);
			if (!pstmt.execute()) {
				System.out.println(type + " Uploaded Successfully");
				closeConnection();
				return true;
			} else
				throw new SQLException();
		} catch (SQLException e) {
			e.printStackTrace();
			System.err.println(type + " Uploading Failed");
			closeConnection();
			return false;
		}
	}

	// 삭제 메소드 통일
	private boolean executeDeletion(String type, String sql) {
		try {
			getConnection();
			pstmt = conn.prepareStatement(sql);
			if (!pstmt.execute()) {
				System.out.println(type + " Deleted Successfully");
				closeConnection();
				return true;
			} else
				throw new SQLException();
		} catch (SQLException e) {
			e.printStackTrace();
			System.err.println(type + " Deletion Failed");
			closeConnection();
			return false;
		}
	}

	private boolean executeUpdate(String type, String sql) {
		try {
			getConnection();
			pstmt = conn.prepareStatement(sql);
			if (!pstmt.execute()) {
				System.out.println(type + " Updated Successfully");
				closeConnection();
				return true;
			} else
				throw new SQLException();
		} catch (SQLException e) {
			e.printStackTrace();
			System.err.println(type + " Update Failed");
			closeConnection();
			return false;
		}
	}

	private ResultSet executeSelect(String type, String sql) {
		try {
			getConnection();
			pstmt = conn.prepareStatement(sql);
			return pstmt.executeQuery();
		} catch (SQLException e) {
			e.printStackTrace();
			System.err.println(type + " Getting Info Failed");
			closeConnection();
			return null;
		}
	}

	private float getRate(int code) {
		String sql = String.format("select rate from reservation where code = %d and rate != null and rate != 0", code);
		try {
			float count = (float) 0.0;
			rs = executeSelect("Rate", sql);
			float sum = 0;
			while (rs.next()) {
				count++;
				sum += rs.getInt(1);
			}
			closeConnection();
			return sum / count;
		} catch (SQLException e) {
			e.printStackTrace();
			closeConnection();
			return 0;
		}
	}
	
	private boolean closeConnection() {
		try {
			if(!conn.isClosed())
				conn.close();
			if(!pstmt.isClosed())
				pstmt.close();
			if(!rs.isClosed())
				rs.close();
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	/***********************************************************************************/
	
/**************************** snakeGame rank **********************************************/
	
	//랭크 테이블 생성
	public boolean addRankTable() {
		String sql = String.format("create table snakeRank(\n"
				+ "log varchar(20) not null,\n"
				+ "scores int(100) not null\n"
				+ ");");
		try {
			getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.execute();
			closeConnection();
			return true;
		} catch (SQLException e) {
			closeConnection();
			return false;
		}
	}
	//랭크 테이블 제거
	public boolean removeRankTable() {
		
		String sql = String.format("drop table snakeRank");
		try {
			getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.execute();
			closeConnection();
			return true;
		} catch (SQLException e) {
			closeConnection();
			return false;
		}
	}
	//랭크 추가
	public boolean addRank(String log,int score) {
		if(checkDupRanker(log)) {
			String sql = String.format("insert into snakeRank(log,scores) values('%s',%d)", log,score);
			try {
				getConnection();
				pstmt = conn.prepareStatement(sql);
				pstmt.execute();
				return true;
			} catch (SQLException e) {
				return false;
			}
		}
		else {
			updateRankerId(log,score);
			return false;
		}
	}
	
	//id 중복일때 스코어 갱신
	public boolean updateRankerId(String id,int score) {
		System.out.println(id);
		int inScore=highRank(id, score);
		String sql = String.format("Update snakeRank set scores = %d where log='%s'" , inScore,id);
		try {
			getConnection();
			pstmt=conn.prepareStatement(sql);
			pstmt.execute();
		} catch (Exception e) {
		}
		return true;
	}
	// 중복 스코어일 때 넣을 스코어와 넣어져 있는 스코어 비교
	public int highRank(String log, int score) {
		String sql = String.format("select scores from snakeRank where log = '%s'",log);
		getConnection();
		try {
			int beforeScore=0;
			pstmt=conn.prepareStatement(sql);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				beforeScore=rs.getInt("scores");
			}
			if(beforeScore<score) {
				closeConnection();
				return score;
			}
			else {
				closeConnection();
				return beforeScore;
			}
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
	}	
	
	
	//랭크리스트 가져오기
	public ArrayList<String> snakeRankList() {
		ArrayList<String> rankList=new ArrayList<String>();
		String sql = String.format("select * from snakeRank order by scores desc");
		getConnection();
		int n=1;
		try {
			pstmt=conn.prepareStatement(sql);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				String data=rs.getString("log")+"/"+rs.getInt("scores");
				rankList.add(data);
				//10명의 랭크만 가져오기
				if(n==10) {
					break;
				}
				n++;
			}
			closeConnection();
		} catch (Exception e) {
			e.printStackTrace();
			closeConnection();
			return null;
		}
		closeConnection();
		return rankList;
	}	
	
	public boolean checkDupRanker(String log) {
		String sql = String.format("select log from snakeRank where log ='%s'", log);
		try {
			getConnection();
			pstmt = conn.prepareStatement(sql);
			rs=pstmt.executeQuery();
			if (rs.next()) {
				System.err.println("중복된 ID");
				closeConnection();
				return false;
			} else
				closeConnection();
				throw new SQLException();
		} catch (SQLException e) {
			closeConnection();
			return true;
		}
	}
	
	
	//유저 포인트 업데이트
	public boolean updateUserPoint(String id,int point) {
		int UserPoint=getUserPoint(id)+point;
		String sql = String.format("Update users set point = %d where id='%s'" , UserPoint,id);
		try {
			getConnection();
			pstmt=conn.prepareStatement(sql);
			pstmt.execute();
		} catch (Exception e) {
			// TODO: handle exception
		}
		closeConnection();
		return true;
	}
	//유저 포인트 가져오기
	public int getUserPoint(String log) {
		String sql = String.format("select point from users where id = '%s'",log);
		getConnection();
		try {
			pstmt=conn.prepareStatement(sql);
			rs=pstmt.executeQuery();
			rs.next();
			int UserPoint=rs.getInt("point");
			closeConnection();
			return UserPoint;
		} catch (Exception e) {
			e.printStackTrace();
			closeConnection();
			return 0;
		}
	}	
	
	private String getMonthRange(String month) {
		int year = Integer.parseInt(month.substring(0,4));
		int mon = Integer.parseInt(month.substring(5));
		
		if(++mon > 12) {
			year++;
			mon = 1;
		}
		String date = "";
		if(mon < 10)
			date+="0"+mon;
		return year+"-"+mon+"01";
	}
	/***********************************************************************************/
}