/**
 * 
 */
 
function pageUp() {
   	let page=document.body.querySelector("#page");
   	let endPage=document.body.querySelector("#endpage");

   	if(parseInt(page.getAttribute("value"))<parseInt(endPage.getAttribute("value"))){
		page.setAttribute("value",parseInt(page.getAttribute("value"))+1);
	}
	else{
		
	}
   	location.href=`/green_project/notice?pageNum=${page.getAttribute("value")}`;
}
function pageDown() {
   	let page=document.body.querySelector("#page");
   	let endPage=document.body.querySelector("#endpage");

   	if(parseInt(page.getAttribute("value"))>1){
		page.setAttribute("value",parseInt(page.getAttribute("value"))-1);
	}
	else{
		
	}
   	location.href=`/green_project/notice?pageNum=${page.getAttribute("value")}`;
}
 


//$("#liveChatBn").on("click", liveChatOn);