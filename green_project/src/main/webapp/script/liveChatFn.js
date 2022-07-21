/**
 * 
 */
let auth=document.body.querySelector("#auth_");
let userAuth=auth.getAttribute("value");
function liveChatOn() {
   	let iframe=document.body.querySelector("#iframeLocal");
   	console.log(userAuth);
	if(userAuth==="0"){
		location.href="/green_project/masterWebsocket";
	}
   	if(iframe.getAttribute("name")==="1"){
		iframe.innerHTML=`<div id="wraps"><iframe id="livaChatIf" src="/green_project/websocket" width="320" height="320" style="display:block;"></iframe></div>`;  
		iframe.setAttribute("name","2");
	}
   	else if(iframe.getAttribute("name")==="2"){
		iframe.innerHTML=``;  
		iframe.setAttribute("name","1");
	}
   	
}
 
//$("#liveChatBn").on("click", liveChatOn);