package controller;

import java.sql.Date;
import java.util.ArrayList;

import model.ReservationDTO;

public class ReservationDAO {
	/***********************************************************************************/

	// 담당 : 이인상

	/***********************************************************************************/
	private static ReservationDAO instance = new ReservationDAO();
	
	private ReservationDAO() {}
	private DBManager dbm = new DBManager();
	
	public static ReservationDAO getInstance() {
		return instance;
	}
	/**********************************************************************************************/
	
	public boolean addNewReservation(String id, int code, int price, Date checkIn, Date checkOut) {
		ReservationDTO rsrv = new ReservationDTO(checkIn, checkOut, price, id, code);
		return dbm.addReservation(rsrv);
	}
	
	public ArrayList<ReservationDTO> getList(String today){
		return dbm.getReservationList(today);
	}
	public ArrayList<ReservationDTO> getLists(String id){
		return dbm.getReservationLists(id);
	}
	
	public int reservationCount(String id) {
		return dbm.getReservationCount(id);
	}
	public boolean deleteReservation(String id, int code) {
		ReservationDTO reservation= dbm.getReservation(id, code);
		if(checkValidId(id, reservation)){
			return dbm.deleteReservation(reservation);
		}
		else { 
			return false;
		}
	}
	
	public boolean isValidDate(int code, Date checkIn, Date checkOut) {
		return dbm.validToReseve(code, checkIn, checkOut);
	}
	
	public boolean deleteReservation(int reserve_code) {
		return dbm.deleteReservation(reserve_code);
	}
	public ArrayList<ReservationDTO> getReviewList(int code){
		return dbm.getReviewList(code);
	}
	
	public boolean updateReview(int code, int rate) {
		return dbm.updateReview(code,rate);
	}
	
	/**********************************************************************************************/
	
	private boolean checkValidId(String id, ReservationDTO reservation) {
		return id.equals(reservation.getId());
	}
}
