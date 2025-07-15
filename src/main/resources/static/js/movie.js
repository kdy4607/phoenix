
    const selectedTags = new Set();

    function toggleTag(el) {
    const tagId = parseInt(el.dataset.id);
    el.classList.toggle("selected");
    selectedTags.has(tagId)
    ? selectedTags.delete(tagId)
    : selectedTags.add(tagId);
    submitFilter();
}

    function handleSearch(event) {
    event.preventDefault();
    submitFilter();
    return false;
}

    function submitFilter() {
        const title = document.querySelector('input[name="title"]').value;
        const status = document.querySelector('input[name="status"]').value;  // ✅ 탭 상태 읽기

        fetch("/movies/filter", {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify({
                title: title,
                tagIds: [...selectedTags],
                status: status  // ✅ 탭 상태 포함
            }),
        })
            .then((res) => res.text())
            .then((html) => {
                document.getElementById("movie-container").innerHTML = html;
            })
            .catch((err) => console.error("필터링 실패:", err));
    }

    // 태그 접기펴기
    function toggleTags() {
    const container = document.querySelector(".tag-container");
    container.classList.toggle("collapsed");
}

    // 기존 코드 그대로 유지…
