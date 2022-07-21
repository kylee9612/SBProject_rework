/**
 * 
 */
 
// WebSocket 오브젝트 생성
							  //ws웹소켓			   //프로젝트명 / 호스트명
let webSocket = new WebSocket("ws://localhost:8081/green_project/websocket");
// 콘솔 텍스트 오브젝트
let messageTextArea = document.getElementById("messageTextArea");


webSocket.onopen = function(message) {
	//웹소켓 접속되면 콘솔 텍스트에 메시지를 출력한다.
	messageTextArea.value += "상담연결.\n";
};

webSocket.onclose = function(message) {
	//웹소켓 서버와 접속해제 시 콘솔 텍스트에 메시지를 출력한다.
	messageTextArea.value += "상담종료.\n";
};

webSocket.onerror = function(message) {
	//웹소켓 서버와 통신 중에 에러가 발생 콘솔 텍스트에 메시지를 출력
	messageTextArea.value += "error...\n";
};

// WebSocket 서버로 부터 메시지가 오면 호출되는 함수
webSocket.onmessage = function(message) {
	// 콘솔 텍스트에 메시지를 출력한다.
	messageTextArea.value += "운영자 => " + message.data + "\n";
};


function sendMessage() {
	// 보낼 메시지를 작성하는 박스
	let message = document.getElementById("textMessage");
	// 콘솔 텍스트에 메시지를 출력
	messageTextArea.value += "나 => " + message.value + "\n";
	// 웹소켓 서버에 메시지를 보낸다
	webSocket.send(message.value);
	// 텍스트 박스를 초기화
	message.value = "";
}


// 웹소켓 접속 해제
function disconnect() {
	webSocket.close();
}

$('#textMessage').keyup(function (e) {
 	if (e.keyCode === 13) {
  		sendMessage();
	}
});
