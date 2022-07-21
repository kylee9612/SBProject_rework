/**
 * 
 */ 
   
function saveToDos(token) { //item을 localStorage에 저장합니다. 
            typeof(Storage) !== 'undefined' && sessionStorage.setItem('AccessKEY', JSON.stringify(token)); 
        };

        window.Kakao.init('b10445d600962e3d39e9fbb2dd8f7b3e');
        
        function kakaoLogin() {
            window.Kakao.Auth.login({
                scope: 'profile_nickname, account_email', //동의항목 페이지에 있는 개인정보 보호 테이블의 활성화된 ID값을 넣습니다.
                success: function(response) {
                    saveToDos(response.access_token)  // 로그인 성공하면 사용자 엑세스 토큰 sessionStorage에 저장
                    window.Kakao.API.request({ // 사용자 정보 가져오기 
                        url: '/v2/user/me',
                        success: (res) => {
                            const kakao_account = res.kakao_account;
                           
                            alert('로그인 성공');
                            window.location.href='/green_project/login/join?kid='+JSON.stringify(res.id);
                        }
                    });
                },
                fail: function(error) {
                    console.log(error);
                }
            });
        };
        const login = document.querySelector('#kakaoLogin');
        login.addEventListener('click', kakaoLogin);

  