let bookmarkAlertShown = false;

function toggleBookmark(elem) {
    const isLoggedIn = elem.getAttribute("data-logged-in") === "true";
    const movieId = elem.getAttribute("data-movie-id");
    // 네, setAttribute()를 직접 호출하지 않아도 getAttribute()는 사용할 수 있습니다.
    //     왜냐하면, HTML 안에 직접 작성된 속성(data-* 등)은 이미 요소의 attribute로 등록되어 있기 때문입니다.

    if (!isLoggedIn) {
        if (!bookmarkAlertShown) {
            alert("로그인 해주세요.");
        }
        return;
    }

    // 토글 UI
    const currentlyBookmarked = elem.classList.contains("bookmarked"); // 현재 상태 읽기
    const newBookmarkedState = !currentlyBookmarked;
    // AJAX 호출
    fetch("/bookmark", {
        method: "POST",
        headers: {
            "Content-Type": "application/json"
        },
        body: JSON.stringify({
            movieId: movieId,
            bookmarked: newBookmarkedState  // 토글 후의 상태를 보냄
        })
    }).then(res => {
        if (!res.ok) {
            throw new Error("서버 오류");
        }
        return res.text();
    }).then(msg => {
        console.log("북마크 처리:", msg);
        // 성공했으니 토글 UI 반영
        elem.classList.toggle("bookmarked");
    }).catch(err => {
        alert("북마크 실패");
        console.error(err);
    });
}
