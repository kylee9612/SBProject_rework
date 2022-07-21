/**
 * 
 */
 
function liveChatOn() {
   	let iframe=document.body.querySelector("#iframeLocal");
   	if(iframe.getAttribute("name")==="1"){
		iframe.innerHTML=`<iframe id="livaChatIf" src="./websocket" width="320" height="220" style="display:block;"></iframe>`;  
		iframe.setAttribute("name","2");
	}
   	else if(iframe.getAttribute("name")==="2"){
		iframe.innerHTML=``;  
		iframe.setAttribute("name","1");
	}
   	
}
 
//$("#liveChatBn").on("click", liveChatOn);