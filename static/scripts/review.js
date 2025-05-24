const token = localStorage.getItem("token");

init();

async function init() {
  checkSignin();
  setBackArrow();
  setTitle();
  loadReview();
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
  async function loadReview() {
    let data = await loadData();
    renderData(data);
    async function loadData() {
      let id = location.pathname.split("/")[2];
      let url = `/api/review/${id}`;
      let request = new Request(url, {
        headers: {
          "Authorization": `Bearer ${token}`
        },
      });
      let res = await fetch(request);
      let resData = await res.json();
      let data = resData.data;
      return data
    }
    function renderData(data) {
      console.log(data);

      for (const item of data) {
        appendReview(item);
      }

      function appendReview(data) {
        let main = document.querySelector("div.main");
        let item = document.createElement("div");
        let user = document.createElement("div");
        let name = document.createElement("div");
        let stars = document.createElement("div");
        let value = document.createElement("div");
        let date = document.createElement("div");
        let like = document.createElement("div");
        let likeBtn = document.createElement("div");
        let img = document.createElement("img");
        let span = document.createElement("span");
        let content = document.createElement("div");
        let text = document.createElement("div");
        let img2 = document.createElement("img");
        item.className = "item";
        item.id = data[0];
        user.className = "user";
        name.className = "name";
        name.textContent = data[1];
        user.appendChild(name);
        stars.className = "stars";
        stars.textContent = "★★★★★";
        value.className = "value";
        value.textContent = "★★★★★";
        value.style.width = `calc(${data[2]} / 5 * 100%)`;
        stars.appendChild(value);
        user.appendChild(stars);
        date.className = "date";
        date.textContent = data[3].slice(0, 10);
        user.appendChild(date);
        like.className = "like";
        likeBtn.className = "like-btn";
        img.setAttribute("src", "/static/images/like-unfilled.png")
        likeBtn.appendChild(img);
        like.appendChild(likeBtn);
        span.textContent = data[4];
        like.appendChild(span);
        user.appendChild(like);
        item.appendChild(user);
        content.className = "content";
        text.className = "text";
        text.textContent = data[5];
        content.appendChild(text);
        if (data[6] !== null) {
          img2.setAttribute("src", data[6])
        }
        content.appendChild(img2);
        item.appendChild(content);
        main.appendChild(item);
      }
    }
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
    let form = document.querySelector(".post-dialog form");
    closeBtn.addEventListener("click", function () {
      let dialog = document.querySelector(".post-dialog");
      dialog.style.display = "none";
    });
    form.addEventListener("submit", async function (event) {
      event.preventDefault();
      let submitter = this.querySelector("button");
      let formData = new FormData(this, submitter);
      let id = location.pathname.split("/")[2];
      id = id.toString()
      formData.append("product_id", id);
      // for (let [key, value] of formData) {
      //   console.log(`${key}: ${value}`);
      // }
      let url = "/api/review";
      let init = {
        method: "POST",
        headers: {
          "Authorization": `Bearer ${token}`
        },
        body: formData,
      };
      let request = new Request(url, init);
      let res = await fetch(request);
      let resData = await res.json();
      console.log(resData);
    });
  }
}
