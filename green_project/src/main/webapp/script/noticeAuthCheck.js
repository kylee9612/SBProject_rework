/**
 * 
 */

let auth=document.body.querySelector("#auth");
let userAuth=auth.getAttribute("value");
console.log(auth);
if(userAuth!==0){
}
else{
	//alert("권한이 없습습니다.s"+"d"+auth);
	location.href="/green_project/notice";
}