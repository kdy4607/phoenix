function logout() {
    yse = confirm("Are you sure you want to logout?")
    if (yse) {
        location.href = '/logout'
    }
}

function login() {
    alert("Please Sign in first ! ")
}