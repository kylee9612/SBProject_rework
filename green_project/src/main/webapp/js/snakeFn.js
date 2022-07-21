/**
 * 
 */
 let sY=5;
let sX=4;
let snakeLength=4;
const SIZE=20;
const snakeArray=new Array();
const tempArray=new Array();

const gameContainer=document.body.querySelector('.gameContainer');

let gameOverBanner=document.createElement('div');
gameOverBanner.setAttribute('class','gameOver');
let gameWinBanner=document.createElement('div');
gameWinBanner.setAttribute('class','gameWin');
gameContainer.append(gameOverBanner);
gameOverBanner.setAttribute('style','display:none');
gameContainer.append(gameWinBanner);
gameWinBanner.setAttribute('style','display:none');
let map;

let rankTitle=document.body.querySelector('.rankTitle');
rankTitle.innerText=`RANK`;
    
function setMap(){
    map=document.createElement('div');
    map.setAttribute('class', 'map');

    for(let n=0; n<20; n++){
        for(let i=0; i<20; i++){
            let bl= document.createElement('div');
            bl.setAttribute('class','block');
            bl.setAttribute('id',`b${n}x${i}`);
            map.append(bl);
        }
    }
    gameContainer.append(map);
}
setMap();
setSnake();

//스네이크 세팅
function setSnake(){
    for(let i=0; i<snakeLength; i++){
        if(i===0){
            const snakeXY=document.body.querySelector(`#b${sY}x${sX}`);
            snakeXY.setAttribute('class','snakeHead');
            snakeArray.push(snakeXY);

        }
        else{
            const snakeXY=document.body.querySelector(`#b${sY}x${sX+i}`);
            snakeXY.setAttribute('class','snake');
            snakeArray.push(snakeXY);
        }
    }
}
//스네이크 이동
function moveSnake(){
    //스네이크 길이만큼 머리를 따라가며 이동
    let endSnake;
    for(let i=snakeArray.length-1; i>=0; i--){
        if(i===0){
            let moveId=document.body.querySelector(`#b${sY}x${sX}`);
            if(moveId.getAttribute('class')==='item'){
                snakeLength++;
                snakeArray.push(endSnake); 
            }
            else if(moveId.getAttribute('class')==='snake'){
                //게임오버
                gameOver();
            }
            else{
                endSnake.setAttribute('class','block');
            }
            moveId.setAttribute('class','snakeHead');
            snakeArray[0]=moveId;
        }
        else if(i!==0){
            if(i===snakeArray.length-1){
                endSnake=snakeArray[i];
            }
            let tempId=snakeArray[i-1].getAttribute('id');
            let tempIdx=document.body.querySelector(`#${tempId}`);
            snakeArray[i]=tempIdx;
            snakeArray[i].setAttribute('class','snake');
        }

    }
}

function cleanMap(){
    for(let i=0; i<SIZE; i++){
        for(let n=0; n<SIZE; n++){
            let checkIdx=document.body.querySelector(`#b${i}x${n}`);
            checkIdx.setAttribute('class','block');
        }
    }
}
function resetSetting(){
    sY=5;
    sX=4;
    snakeLength=4;
    snakeArray.length=0;
    tempArray.length=0;
    delInter=setInterval(gameWin,500);
}

const reset=document.body.querySelector('.reset');
reset.addEventListener('click',e=>{
    // window.location.reload();
    gameWinBanner.setAttribute('style','display:none');
    gameOverBanner.setAttribute('style','display:none');
    map.setAttribute('style','display:flex');
    cleanMap();
    resetSetting();
    setSnake();
})
let winnerNum=1;

let user=document.body.querySelector('#userId').getAttribute("value");
//게임 승리
function gameWin(){
    if(snakeLength===101){
        map.setAttribute('style', 'display:none');
        gameWinBanner.setAttribute('style','display:block');
        let winner=user;
		gameFinish();
        snakeLength=4;
        clearInterval(delInter);
        //if(winner!==null){
          //  let addRank=document.body.querySelector('.rankBoard');
            //addRank.innerHTML+=`<div>${winnerNum}.${winner}</div>`;
            //winnerNum++;
        //}
    }
}

//게임 오버
function gameOver(){
    map.setAttribute('style', 'display:none');
    gameOverBanner.setAttribute('style','display:block');
	gameFinish();
    
}

//게임 종료 시
function gameFinish(){
	location.href=`./ServicesServlet?log=${user}&score=${snakeLength-1}&command=snakeGame`;
}


//이동 예외 확인
function moveCheck(YY,XX){
    if(XX<0||XX>=SIZE||YY<0||YY>=SIZE){

    }
    else{
        sY=YY;
        sX=XX;
    }
}

//아이템 생성여부 확인
function checkItem(){
    for(let i=0; i<SIZE; i++){
        for(let n=0; n<SIZE; n++){
            let checkIdx=document.body.querySelector(`#b${i}x${n}`);
            if(checkIdx.getAttribute('class')==='item'){
                return true;
            }
        }
    }
    return false;
}

//아이템 생성
function addItem(){
    if(!checkItem()){
        while(true){
            let itemY=Math.floor(Math.random()*SIZE);
            let itemX=Math.floor(Math.random()*SIZE);
            const itemXY=document.body.querySelector(`#b${itemY}x${itemX}`);
            if(itemXY.getAttribute('class')==='block'){
                itemXY.setAttribute('class','item');
                break;
            }
        }
    }
}

//게임 승리 카운트
function winCnt(){
    let win=document.body.querySelector('.winCnt');
    win.innerHTML=`꼬리가 100개 되면 승리<br><br>`;
    win.innerHTML+=`&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp현재 꼬리:${snakeLength-1}`;
}

setInterval(addItem,1000);
addItem();
setInterval(winCnt,500);
let delInter=setInterval(gameWin,500);


// 키다운을 받으면 이동할 좌표
document.addEventListener('keydown',e=>{
	
    const regex=/[a-z|A-Z]/g;
        if(regex.test(e.key)){
            let YY=sY;
            let XX=sX;
            if(e.key=='ArrowLeft'||e.key==='a'||e.key==='A'){
                XX--;
            }
            else if(e.key=='ArrowRight'||e.key==='d'||e.key==='D'){
                XX++;
            }
            else if(e.key=='ArrowUp'||e.key==='w'||e.key==='W'){
                YY--;
            }
            else if(e.key=='ArrowDown'||e.key==='s'||e.key==='S'){
                YY++;
            }
            if(e.key=='ArrowLeft'||e.key==='a'||e.key==='A'||e.key==='S'||e.key==='D'||e.key==='W'||e.key=='ArrowRight'||e.key==='d'||e.key=='ArrowUp'||e.key==='w'||e.key=='ArrowDown'||e.key==='s'){
                moveCheck(YY,XX);
                moveSnake();

            }
        }
        else{
            alert('영어키로 변경해주세요.');
        }
})