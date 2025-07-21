

// 전체 영화 데이터를 저장할 배열
let allMovies = [];

// 전체 태그 데이터를 저장할 배열
let allTags = [];

// 현재 선택된 상태 탭 (기본은 '상영중')
let currentStatus = "showing";

// 선택된 태그들을 저장하는 집합 (중복 없이 저장됨)
const selectedTags = new Set();

// 페이지가 완전히 로드되면 실행되는 함수
window.onload = function () {
    // "영화 로딩 중"이라는 메시지를 화면에 보여줌
    showLoadingMessage("🎬 Loading movies...");

    // 서버에서 영화와 태그 데이터를 요청함
    fetch("/movies/all-data")
        // 응답받은 데이터를 JSON 형식으로 변환
        .then((res) => res.json())
        // 변환된 데이터를 가지고 초기 설정 실행
        .then((data) => {
            // 서버에서 받은 영화 목록을 저장
            allMovies = data.movies;
            // 서버에서 받은 태그 목록을 저장
            allTags = data.tags;

            // URL에 포함된 필터 정보(title, status, tags)를 읽고 초기 상태 설정
            parseURLParamsAndInit();
        })
        // 데이터를 불러오지 못했을 때 에러 메시지 출력
        .catch(() => {
            showLoadingMessage("❌ Failed to load movies.");
        });
};

// 로딩 메시지를 출력하는 함수
function showLoadingMessage(message) {
    // 영화 카드들을 넣을 HTML 요소를 가져옴
    const container = document.getElementById("movie-container");
    // 그 요소 안에 메시지를 넣음
    container.innerHTML = `<div class="loading">${message}</div>`;
}

// URL에서 필터 파라미터(status, title, tags)를 읽어와 초기 설정하는 함수
function parseURLParamsAndInit() {
    const urlParams = new URLSearchParams(window.location.search);

    // URL에서 status 값을 읽음 (없으면 기본값 showing)
    currentStatus = urlParams.get("status") || "showing";

    // 검색어(title)를 URL에서 읽고 input에 채움
    const title = urlParams.get("title") || "";
    const titleInput = document.querySelector('input[name="title"]');
    if (titleInput) titleInput.value = title;

    // URL에서 tags 값을 읽고 Set에 저장
    const tagsParam = urlParams.get("tags");
    if (tagsParam) {
        const tagIds = tagsParam.split(",").map((id) => parseInt(id));
        tagIds.forEach((id) => selectedTags.add(id));
    }

    // 태그 렌더링 실행
    renderTags(allTags);
    // 탭 상태 설정 및 필터링 실행
    setStatus(currentStatus);
}

// 현재 필터 상태를 URL에 반영하는 함수 (뒤로가기/공유용)
function updateURLParams() {
    const url = new URL(window.location);

    // 현재 탭 상태(status)를 URL에 추가
    url.searchParams.set("status", currentStatus);

    // 검색어가 있으면 URL에 추가
    const title = document.querySelector('input[name="title"]').value.trim();
    if (title) {
        url.searchParams.set("title", title);
    } else {
        url.searchParams.delete("title");
    }

    // 선택된 태그가 있으면 URL에 추가
    if (selectedTags.size > 0) {
        url.searchParams.set("tags", [...selectedTags].join(","));
    } else {
        url.searchParams.delete("tags");
    }

    // URL을 새로 고침 없이 변경함
    window.history.replaceState({}, "", url);
}

// 태그를 클릭했을 때 실행되는 함수
function toggleTag(el) {
    const tagId = parseInt(el.dataset.id); // 태그의 ID를 가져옴
    el.classList.toggle("selected");       // CSS 클래스 토글

    // 태그가 이미 선택되어 있으면 제거, 아니면 추가
    if (selectedTags.has(tagId)) {
        selectedTags.delete(tagId);
    } else {
        selectedTags.add(tagId);
    }

    // 필터링 다시 적용
    applyFilters();
}

// 검색폼에서 검색을 눌렀을 때 실행되는 함수
function handleSearch(event) {
    event.preventDefault(); // 폼 전송 막기
    applyFilters();         // 필터링 적용
    return false;
}

// 상태 탭(상영중/개봉예정 등)을 설정하는 함수
function setStatus(status) {
    currentStatus = status; // 상태 저장

    // 모든 탭에서 'active' 클래스를 제거
    document.querySelectorAll(".movie-tab a").forEach((tab) => {
        tab.classList.remove("active");
    });

    // 선택된 탭에 'active' 클래스 추가
    const activeTab = document.querySelector(`.tab-${status}`);
    if (activeTab) activeTab.classList.add("active");

    // ✅ 탭을 누르면 검색어를 초기화
    const titleInput = document.querySelector('input[name="title"]');
    if (titleInput) {
        titleInput.value = "";
    }


    // 필터링 다시 적용
    applyFilters();
}

// 필터링을 적용해서 영화 목록을 새로 그리는 함수
function applyFilters() {
    const titleInput = document.querySelector('input[name="title"]');
    const title = titleInput ? titleInput.value.trim().toLowerCase() : "";

    const filtered = allMovies.filter((movie) => {
        const matchTitle = !title || movie.title.toLowerCase().includes(title);

        const releaseDate = new Date(movie.release_date);
        const today = new Date();
        let matchStatus = true;
        if (currentStatus === "showing") {
            matchStatus = releaseDate <= today;
        } else if (currentStatus === "upcoming") {
            matchStatus = releaseDate > today;
        }

        const movieTagIds = movie.m_tagList.map((tag) => tag.tag_id);
        const matchTags = selectedTags.size === 0 || [...selectedTags].some((id) => movieTagIds.includes(id));


        return matchTitle && matchStatus && matchTags;
    });

    // ⭐️ 평점 높은 순으로 정렬
    filtered.sort((a, b) => b.user_critic - a.user_critic);

    // ⭐️ 정렬된 순서대로 랭킹 부여
    filtered.forEach((movie, idx) => {
        movie.ranking = idx + 1;
    });

    setTimeout(() => {
        renderMovies(filtered);
        updateURLParams();
    }, 200);
}


// 태그 목록 펼치기/접기 토글
function toggleTags() {
    const container = document.querySelector(".tag-container");
    container.classList.toggle("collapsed");
}

// 태그들을 화면에 렌더링하는 함수
function renderTags(tags) {
    const tagContainer = document.getElementById("tag-container");
    tagContainer.innerHTML = ""; // 초기화

    const groups = ["Genre", "Studio", "Country", "Mood"]; // 태그 그룹

    groups.forEach((group) => {
        const groupDiv = document.createElement("div");
        groupDiv.className = `tag-group ${group.toLowerCase()} tag-group-${group.toLowerCase()}`;

        const groupTitle = document.createElement("div");
        groupTitle.className = "tag-group-name";
        groupTitle.textContent = group;
        groupDiv.appendChild(groupTitle);

        const tagsDiv = document.createElement("div");
        tagsDiv.className = "tags-group";

        // 그룹에 해당하는 태그만 필터링
        tags
            .filter((tag) => tag.tag_type === group)
            .forEach((tag) => {
                const tagSpan = document.createElement("span");
                tagSpan.className = "tag";
                tagSpan.dataset.id = tag.tag_id;
                tagSpan.textContent = tag.tag_name;

                // 선택된 태그면 selected 클래스 추가
                if (selectedTags.has(tag.tag_id)) {
                    tagSpan.classList.add("selected");
                }

                // 클릭 시 태그 선택/해제
                tagSpan.onclick = function () {
                    toggleTag(tagSpan);
                };

                tagsDiv.appendChild(tagSpan);
            });

        groupDiv.appendChild(tagsDiv);
        tagContainer.appendChild(groupDiv);
    });
}

// 필터링된 영화들을 화면에 렌더링하는 함수
function renderMovies(movies) {
    const container = document.getElementById("movie-container");
    container.innerHTML = ""; // 초기화

    // 영화가 없으면 메시지 표시
    if (movies.length === 0) {
        container.innerHTML = `<div class="loading">😢 No movies found.</div>`;
        return;
    }

    // 영화 카드 하나씩 생성
    movies.forEach((movie, index) => {
        const card = document.createElement("div");
        card.className = "movie-card movie-card-wrapper";

        const posterWrap = document.createElement("div");
        posterWrap.className = "poster-rating-wrapper";
        posterWrap.onclick = () => location.href = `oneMovieDetail?movie_id=${movie.movie_id}`;

        const img = document.createElement("img");
        img.src = movie.poster_url;
        img.alt = "포스터";

        const rank = document.createElement("div");
        rank.className = "movie-ranking";
        rank.textContent = movie.ranking || index + 1;

        const rating = document.createElement("div");
        rating.className = "movie-rating";
        rating.textContent = movie.rating;

        posterWrap.appendChild(img);
        posterWrap.appendChild(rank);
        posterWrap.appendChild(rating);

        const textWrap = document.createElement("div");
        textWrap.className = "movie-text-wrapper";

        const title = document.createElement("div");
        title.className = "movie-title";
        title.textContent = movie.title;

        const stars = document.createElement("span");
        stars.className = "value movie-stars";
        const starCount = Math.round(movie.user_critic);
        stars.innerHTML = "⭐".repeat(starCount); // 별점 표시

        const release = document.createElement("div");
        release.className = "movie-release-date";
        release.textContent = new Date(movie.release_date).toLocaleDateString("ko-KR");

        const tagListWrap = document.createElement("div");
        tagListWrap.className = "tag-list-wrapper";

        // 영화 태그들 렌더링
        movie.m_tagList.forEach((tag) => {
            const tagSpan = document.createElement("span");
            tagSpan.className = `tag tag-${tag.tag_type.toLowerCase()} tag-item`;
            tagSpan.textContent = tag.tag_name;
            tagListWrap.appendChild(tagSpan);
        });

        textWrap.appendChild(title);
        textWrap.appendChild(stars);
        textWrap.appendChild(release);
        textWrap.appendChild(tagListWrap);

        const director = document.createElement("div");
        director.className = "movie-director";
        director.textContent = movie.director;

        card.appendChild(posterWrap);
        card.appendChild(textWrap);
        card.appendChild(director);

        // '상영중' 탭일 경우만 예매 버튼 표시
        if (currentStatus === "showing") {
            const btn = document.createElement("button");
            btn.className = "btn-book-tickets";
            btn.textContent = "Book Tickets";
            btn.onclick = () => location.href = `schedule?movie_id=${movie.movie_id}`;
            card.appendChild(btn);
        }

        container.appendChild(card);
    });
}
