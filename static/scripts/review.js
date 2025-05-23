const token = localStorage.getItem("token");

init();

async function init() {
  checkSignin();
  setBackArrow();
  setTitle();
  setPostBtn();
  setPostDialog();

  async function checkSignin() {
    let user = await getUser(token);
    if (user == null) {
      alert("請先登入系統");
      location.href = "/";
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
  }
  function setBackArrow() {
    let back = document.querySelector(".back-arrow");
    back.addEventListener("click", function () {
      window.history.back();
    });
  }
  async function setTitle() {
    let id = location.pathname.split("/")[2];
    let url = `/api/products/${id}`;
    let request = new Request(url, {
      headers: {
        "Authorization": `Bearer ${token}`
      },
    });
    let res = await fetch(request);
    let resData = await res.json();
    let data = resData.data;
    let title = document.querySelector(".header .title");
    title.textContent = `【${data[1]}】${data[2]}`;
  }
  function setPostBtn() {
    let btn = document.querySelector(".post-btn");
    btn.addEventListener("click", function () {
      let dialog = document.querySelector(".post-dialog");
      dialog.style.display = "block";
    });
  }
  function setPostDialog() {
    let closeBtn = document.querySelector(".close-btn");
    closeBtn.addEventListener("click", function () {
      let dialog = document.querySelector(".post-dialog");
      dialog.style.display = "none";
    });
  }
}
