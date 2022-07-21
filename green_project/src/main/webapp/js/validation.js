const node = $('#checkAll').get(0);
const checkboxes = $(':checkbox');
const warning = $('.warning');
const req = $(".req");

let log=-1;

function checkVal(form) {
    if (checkboxes.get(1).checked && checkboxes.get(2).checked)
        form.submit();
    else {
        alert('필수항목에 동의해주세요.');
        for (let i = 0; i < warning.length; i++) {
            warning.show();
        }
    }
}
function checkJoinVal(form){
	let check=false;
	
	console.log(req.length);
	
    for(let i=0; i<req.length; i++){
		console.log(req.get(i));
		console.log(req.get(i).value);
		
        if(req.get(i).value === ""){
            warning.show();
			check=true;
		}
    }
	if(check){
		alert("회원가입이 불가능합니다");
	}
	else{
		form.submit();
	}
	

}
function checkLogin(form) {
    if (form.id!=='')
        form.submit();
    else {
        alert('아이디랑 비밀번호를 입력하세요.');
        for (let i = 0; i < warning.length; i++) {
            warning.show();
        }
    }
}

function checkMobile(form) {
    const val = form.mobile.value;
    let check = val.match("(?=010|011|016|019)(?=([0-9]{3}-[0-9]{4}-[0-9]{4})).*");
    
    if (check !== null && check.index === 0) {
        console.log("정상");

    }
    else {
        console.log("비정상");
        alert("올바르지 않은 휴대폰 번호입니다. ###-####-####")
        form.mobile.value = "";
    }
}

$('#mobile').on('keypress', e => {
    if (e.key === 'Enter')
        checkJoinVal($('form').get(0));
});

$('#checkAll').click(e => {
    if (node.checked) {
        for (let i = 0; i < checkboxes.length; i++) {
            checkboxes.get(i)
                .checked = true;
        }
    }
    else {
        for (let i = 0; i < checkboxes.length; i++) {
            checkboxes.get(i)
                .checked = false;
        }
    }
})

function loginAlert(){
	window.alert('로그인완료!');
}
function check(){
	 if(success.equals("no")){
    	 
		alert("아이디및 비밀번호를 확인해주세요");
	
     }
}
