function logout() {
    if (confirm("Are you sure you want to logout?")) {
        console.log('로그아웃 처리 시작');

        // 서버에 로그아웃 요청 (POST 방식)
        fetch('/logout', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            }
        })
            .then(response => {
                if (response.ok) {
                    console.log('로그아웃 성공');
                    alert('로그아웃 되었습니다.');
                    // 메인 페이지로 이동
                    window.location.href = '/';
                } else {
                    console.error('로그아웃 실패');
                    alert('로그아웃 중 오류가 발생했습니다.');
                }
            })
            .catch(error => {
                console.error('로그아웃 오류:', error);
                // 오류가 발생해도 로그아웃 처리
                alert('로그아웃 되었습니다.');
                window.location.href = '/';
            });
    }
}

function login() {
    alert("Please Sign in first!")
}