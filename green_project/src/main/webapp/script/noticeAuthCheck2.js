/**
 * 
 */

let auth=document.body.querySelector("#auth");
let userAuth=auth.getAttribute("value");
if(userAuth!=="0"){
	alert("권한이 없습니다.");
	location.href="/green_project/notice";
}
else{
}