
    let bookmarkAlertShown = false;

    function toggleBookmark(elem) {
    const isLoggedIn = elem.getAttribute("data-logged-in") === "true";
    const movieId = elem.getAttribute("data-movie-id");

    if (!isLoggedIn) {
    if (!bookmarkAlertShown) {
    alert("로그인 해주세요.");
    bookmarkAlertShown = true;
}
    return;
}

    // 토글 UI
    const isBookmarked = elem.classList.toggle("bookmarked");

    // AJAX 호출
    fetch("/bookmark", {
    method: "POST",
    headers: {
    "Content-Type": "application/json"
},
    body: JSON.stringify({
    movieId: movieId,
    bookmarked: isBookmarked
})
}).then(res => {
    if (!res.ok) {
    throw new Error("서버 오류");
}
    return res.text();
}).then(msg => {
    console.log("북마크 처리:", msg);
}).catch(err => {
    alert("북마크 실패");
    console.error(err);
});
}
