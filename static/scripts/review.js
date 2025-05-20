const token = localStorage.getItem("token");


init();


async function init() {
  let dropdowns = document.querySelectorAll("div.dropdown");


  signinCheck();
  dropdownClick();



  async function signinCheck() {
    let user = await getUser(token);
    if (user == null) {
      alert("請先登入系統");
      location.href = "/";
    }
  }
  async function getUser(token) {
    let url = "/api/user/auth";
    let request = new Request(url, {
      headers: { "Authorization": `Bearer ${token}` },
    });
    let res = await fetch(request);
    let resData = await res.json();
    let user = resData.data;
    return user;
  }
  function dropdownClick() {
    for (let dropdown of dropdowns) {
      dropdown.addEventListener("click", function () {
        let content = dropdown.querySelector(".dropdown-content");
        if (content.style.display == "none") {
          content.style.display = "flex";
        } else {
          content.style.display = "none";
        }
      });
    }
  }
}
