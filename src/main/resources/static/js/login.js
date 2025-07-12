// Alert for Check
// alert("Check");

// Login & Logout
function login() {
  alert("Please Sign in first ! ");
}

function logout() {
  if (confirm("Are you sure you want to logout?")) {
    console.log("로그아웃 처리 시작");

    // 서버에 로그아웃 요청 (POST 방식)
    fetch("/logout", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
    })
      .then((response) => {
        if (response.ok) {
          console.log("로그아웃 성공");
          alert("로그아웃 되었습니다.");
          // 메인 페이지로 이동
          window.location.href = "/";
        } else {
          console.error("로그아웃 실패");
          alert("로그아웃 중 오류가 발생했습니다.");
        }
      })
      .catch((error) => {
        console.error("로그아웃 오류:", error);
        // 오류가 발생해도 로그아웃 처리
        alert("로그아웃 되었습니다.");
        window.location.href = "/";
      });
  }
}

// Join Valid Check

// Valid Check Function
// Character Length
function lessThan(input, length) {
  return input.value.length < length;
  // true, false
}
function moreThan(input, length) {
  return input.value.length >= length;
  // true, false
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

// Call Check Function
function call() {
  // Input Value
  const u_id = document.querySelector('input[name="u_id"]');
  const u_pw = document.querySelector('input[name="u_pw"]');
  const u_name = document.querySelector('input[name ="u_name"]');
  const u_address = document.querySelector('input[name="u_address"]');

  // ID Check - At least 6 letters / Fewer than 20 letters / Containable English, case letters, numbers, special symbols ( @_. )
  if (lessThan(u_id, 6) || moreThan(u_id, 20) || containableWords(u_id)) {
    alert(
      "Your ID must be between 6 and 20 characters, using only English letters (uppercase and lowercase), numbers, and special symbols (@_.)"
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
      "Password must be 8-100 characters long, containing only English letters, numbers, and special symbols (!@#$%^&*-_+=)"
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
