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
	
	public boolean addNewReservation(String id, int code,Date checkIn, Date checkOut) {
		ReservationDTO rsrv = new ReservationDTO(checkIn, checkOut, code, id, dbm.getRandomReservationCode());
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
	private boolean checkValidId(String id, ReservationDTO reservation) {
		return id.equals(reservation.getId());
	}
	
	public boolean deleteReservation(int reserve_code) {
		return dbm.deleteReservation(reserve_code);
	}
	public ArrayList<ReservationDTO> getReviewList(int code){
		return dbm.getReviewList(code);
	}
	
	/**********************************************************************************************/
}
