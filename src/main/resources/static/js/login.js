
// Login & Logout //

// Login
function login() {
  alert("Please Sign in first ! ");
}

// Logout
function logout() {
  if (confirm('Do you want to log out?')) {
    console.log('로그아웃 처리 시작');

    // 서버에 로그아웃 요청 (POST 방식)
    fetch('/logout', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      }
    })
        .then(response => {
          // 응답이 성공적이거나 리다이렉트인 경우
          if (response.ok || response.redirected) {
            console.log('로그아웃 성공');
            alert('You are logged out.');
            // 메인 페이지로 이동
            window.location.href = '/';
          } else {
            console.warn('로그아웃 응답 상태:', response.status);
            // 상태가 200이 아니어도 로그아웃 처리 (서버에서 리다이렉트할 수 있음)
            alert('You are logged out.');
            window.location.href = '/';
          }
        })
        .catch(error => {
          console.error('로그아웃 요청 오류:', error);
          // 네트워크 오류가 발생해도 로그아웃 처리
          alert('You are logged out.');
          window.location.href = '/';
        });
  }
}

function logoutEn() {
  if (confirm('Are you sure you want to logout?')) {
    console.log('로그아웃 처리 시작');

    fetch('/logout', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      }
    })
        .then(response => {
          if (response.ok || response.redirected) {
            console.log('로그아웃 성공');
            alert('Logout complete.');
            window.location.href = '/';
          } else {
            console.warn('로그아웃 응답 상태:', response.status);
            alert('Logout complete.');
            window.location.href = '/';
          }
        })
        .catch(error => {
          console.error('로그아웃 요청 오류:', error);
          alert('Logout complete.');
          window.location.href = '/';
        });
  }
}

// Login Check Function
function checkLoginStatus() {
  return fetch('/user/check')
      .then(response => response.json())
      .then(data => data.isLoggedIn)
      .catch(error => {
        console.error('로그인 상태 확인 오류:', error);
        return false;
      });
}

// Join Valid Check //

// Valid Check Function //
// Character Length
function lessThan(input, length) {
  return input.value.length < length;
}
function moreThan(input, length) {
  return input.value.length >= length;
}

// Password Match
function isNotMatch(inputOne, inputTwo) {
  return inputOne.value != inputTwo.value;
}

// Containable Word
function containableWords(input) {
  const allowedIdCharsRegex = /^[A-Za-z0-9@_.]*$/;
  return !allowedIdCharsRegex.test(input.value);
}

// Call Check Function //
function call() {
  // Input Value
  const u_id = document.querySelector('input[name="u_id"]');
  const u_pw = document.querySelector('input[name="u_pw"]');
  const u_name = document.querySelector('input[name ="u_name"]');
  const u_address = document.querySelector('input[name="u_address"]');

  // ID Check - At least 6 letters / Fewer than 20 letters / Containable English, case letters, numbers, special symbols ( @_. )
  if (lessThan(u_id, 6) || moreThan(u_id, 20) || containableWords(u_id)) {
    alert(
      "Your ID must be between 6 and 20 characters, using only English letters (uppercase ade lowercase), numbers, and special symbols (@_.)"
    );
    u_id.value = "";
    u_id.focus();
    return false;
  }

  // Password Check - At least 8 letters / Fewer than 100 letters / Must contain English, case letters, numbers, special symbol ( !@#$%^&*-_+= )
  const charset =
    /^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%^&*_+=-])[A-Za-z0-9!@#$%^&*_+=-]{8,100}$/;
  if (!charset.test(u_pw.value)) {
    alert(
      "Password must be 8-100 characters long, containing only English letters (uppercase and lowercase), numbers, and special symbols (!@#$%^&*-_+=)"
    );
    u_pw.focus();
    return false;
  }

  // Name Check - At least 2 letters / Fewer than 50 letters // Containable English, case letters, Korean
  const nameCharset = /^[가-힣a-zA-Z]*$/;
  if (
    lessThan(u_name, 2) ||
    moreThan(u_name, 50) ||
    !nameCharset.test(u_name.value)
  ) {
    alert(
      "Name must be 2-50 characters long, containing only English letters or Korean characters"
    );
    u_name.value = "";
    u_name.focus();
    return false;
  }

  // Address Check - Fewer than 500 letters
  if (moreThan(u_address, 500)) {
    alert("Address must be less than 500 characters");
    u_address.value = "";
    u_address.focus();
    return false;
  }
  return true;
}
