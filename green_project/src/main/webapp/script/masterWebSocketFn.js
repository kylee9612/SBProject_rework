/**
 * 
 */
 
// WebSocket 오브젝트 생성
							  //ws웹소켓			   //프로젝트명 / 호스트명
let webSocket = new WebSocket("ws://localhost:8081/green_project/masterWebsocket");
// 콘솔 텍스트 오브젝트
let messageTextArea2 = document.getElementById("console");


webSocket.onopen = function(message) {
};

webSocket.onclose = function(message) {
};

webSocket.onerror = function(message) {
};

// WebSocket 서버로 부터 메시지가 오면 호출되는 함수
webSocket.onmessage = function(message) {
	let data= JSON.parse(message.data);
	if(data.status==="visit"){
		let form=$(".template").html();
		form = $("<div class='chatBox'></div>").attr("data-key",data.key).append(form);
		$("body").append(form);
		let $div= $("[data-key='"+data.key+"']");
		let msg = data.key+"님이 입장하셨습니다.\n";
		$div.find(".console").val(msg+"\n");
	}
	else if(data.status==="message"){
		let $div= $("[data-key='"+data.key+"']");
		let log= $div.find(".console").val();
		$div.find(".console").val(log+  data.key+"=>"+ data.message+"\n");
	}
};


$(document).on("click", ".sendBtn", function(){
	//디브 태그를 찾아
	let $div=$(this).closest(".chatBox");
	let message = $div.find(".message").val();
	let key= $div.data("key");
	let log=$div.find(".console").val();
	$div.find(".console").val(log + "나 => " + message + "\n");
	$div.find(".message").val("");
	// 웹소켓 서버에 메시지를 보낸다
	webSocket.send(key+"#"+message);
});


// 웹소켓 접속 해제
function disconnect() {
	webSocket.close();
}

$(document).on("keyup",'#textMessage',function (e) {
 	if (e.keyCode === 13) {
  		//디브 태그를 찾아
		let $div=$(this).closest(".chatBox");
		let message = $div.find(".message").val();
		let key= $div.data("key");
		let log=$div.find(".console").val();
		$div.find(".console").val(log + "나 => " + message + "\n");
		$div.find(".message").val("");
		// 웹소켓 서버에 메시지를 보낸다
		webSocket.send(key+"#"+message);
	}
});
