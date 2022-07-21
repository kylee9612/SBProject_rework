/**
 * 
 */


let log=document.body.querySelector("#log");
console.log(log);
let id=log.getAttribute("value");
function logCheck() {
   	if(id==="null"){
		alert("로그인 후 이용해주세요.");
		console.log("dd");
	}
   	else{
		location.href="/green_project/snakeGame";
		console.log("dd2");
	}
   	
}