package controller;
import controller_action.DeleteItemAction;
import controller_action.DeleteQAAction;
import controller_action.DeleteReservationAction;
import controller_action.DeleteUserAction;
import controller_action.IDFindAction;
import controller_action.JoinAction;
import controller_action.LoginAction;
import controller_action.UpdateQuestionAction;
import controller_action.UpdateUserAction;
import controller_action.WriteAnnouncementAction;
import controller_action.LogoutAction;
import controller_action.MonthAddAction;
import controller_action.MonthDecAction;
import controller_action.PwFindAction;
import item.addItemAction;
import item.reservationAction;
import controller_action.WriteQuestionAction;
import controller_action.delNoticeAction;
import controller_action.likeAction;
import controller_action.snakeRank;
import controller_action.updateAnnouncementAction;
import item.roomInfoAction;
import item.roomListAction;

/***********************************************************************************/

//담당 : 이인상

/***********************************************************************************/

public class ActionFactory {
	private static ActionFactory instance = new ActionFactory();
	
	private ActionFactory() {}
	
	public static ActionFactory getInstance() {
		return instance;
	}
	
	public Action getAction(String command) {
		Action action = null;
		 
		if(command.equals("join"))
			action = new JoinAction();
		else if(command.equals("login"))
			action = new LoginAction();
		else if(command.equals("roomList"))
			action = new roomListAction();
		else if(command.equals("roomInfo"))
			action = new roomInfoAction();
		else if(command.equals("like"))
			action = new likeAction();
		else if(command.equals("reservation"))
			action = new reservationAction();
		else if(command.equals("reservation"))
			action = new reservationAction();
		else if(command.equals("addItem"))
			action = new addItemAction();
		else if(command.equals("writeQuestion"))
			action = new WriteQuestionAction();
		else if(command.equals("updateQuestion"))
			action = new UpdateQuestionAction();
		else if(command.equals("deleteQA"))
			action = new DeleteQAAction();
		else if(command.equals("logout"))
			action = new LogoutAction();
		else if(command.equals("updateUser"))
			action = new UpdateUserAction();
		else if(command.equals("snakeGame"))
			action = new snakeRank();
		else if(command.equals("Announcement"))
			action = new WriteAnnouncementAction();
		else if(command.equals("idFind"))
			action = new IDFindAction();
		else if(command.equals("pwFind"))
			action = new PwFindAction();
		else if(command.equals("deleteUser"))
			action = new DeleteUserAction();
		else if(command.equals("delNotice"))
			action = new delNoticeAction();
		else if(command.equals("updateNotice"))
			action = new updateAnnouncementAction();
		else if(command.equals("monthdec"))
			action = new MonthDecAction();
		else if(command.equals("monthadd"))
			action = new MonthAddAction();
		else if(command.equals("deleteItem"))
			action = new DeleteItemAction();
		else if(command.equals("deleteReservation"))
			action = new DeleteReservationAction();
  
		
		return action;
	}
}
