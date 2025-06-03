init();
async function init() {
  const token = localStorage.getItem("token");
  await checkSignin();
  setBackArrow();
  setTitle();
  loadRating();
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
  async function loadRating() {
    let id = location.pathname.split("/")[2];
    let url = `/api/review/rating/${id}`;
    let request = new Request(url, {
      headers: {
        "Authorization": `Bearer ${token}`
      },
    });
    let res = await fetch(request);
    let result = await res.json();
    document.querySelector(".value.one").style.width = `${result[0]}%`;
    document.querySelector(".value.two").style.width = `${result[1]}%`;
    document.querySelector(".value.three").style.width = `${result[2]}%`;
    document.querySelector(".value.four").style.width = `${result[3]}%`;
    document.querySelector(".value.five").style.width = `${result[4]}%`;
    document.querySelector(".avg .score").textContent = result[5].toFixed(1);
    console.log(result[5].toFixed(1));
    document.querySelector(".stars .value").style.width = `calc(${result[6]}%)`;
    document.querySelector(".caption span").textContent = result[7];
  }
  async function loadReview() {
    let data = await getData();
    await renderPage(data);
    postProduction();
    async function getData() {
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
    async function renderPage(data) {
      for (const item of data) {
        appendReview(item);
      }
      async function appendReview(data) {
        // let isMyLike = await checkMyLike();
        // let isMyPost = await checkMyPost();
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
        // if (isMyPost) {
        //   name.style.backgroundColor = "#fbbc04";
        // }
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
        // if (isMyLike) {
        //   img.setAttribute("src", "/static/images/like-filled.png");
        // } else {
        //   img.setAttribute("src", "/static/images/like-unfilled.png");
        // }
        img.setAttribute("src", "/static/images/like-unfilled.png");
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
        likeBtn.addEventListener("click", async function () {
          let likeDIV = this.parentElement;
          let reviewID = data[0];
          let url = "/api/review/like";
          let init = {
            method: "POST",
            headers: {
              "Authorization": `Bearer ${token}`,
              "Content-Type": "application/json",
            },
            body: JSON.stringify({ reviewID: reviewID }),
          };
          let request = new Request(url, init);
          let res = await fetch(request);
          let resData = await res.json();
          if (resData) {
            let span = likeDIV.querySelector("span");
            let count = span.textContent;
            let icon = likeDIV.querySelector("img");
            count = Number(count);
            count += 1;
            span.textContent = count;
            icon.setAttribute("src", "/static/images/like-filled.png");
          }
        })
        // async function checkMyLike() {
        //   let reviewID = data[0];
        //   let url = `/api/review/mylike/${reviewID}`;
        //   let init = {
        //     headers: {
        //       "Authorization": `Bearer ${token}`,
        //     },
        //   };
        //   let request = new Request(url, init);
        //   let res = await fetch(request);
        //   let resData = await res.json();
        //   if (resData !== null) {
        //     return true;
        //   } else {
        //     return false
        //   }
        // }
        // async function checkMyPost() {
        //   let reviewID = data[0];
        //   let url = `/api/review/mypost/${reviewID}`;
        //   let init = {
        //     headers: {
        //       "Authorization": `Bearer ${token}`,
        //     },
        //   };
        //   let request = new Request(url, init);
        //   let res = await fetch(request);
        //   let resData = await res.json();
        //   if (resData !== null) {
        //     return true;
        //   } else {
        //     return false
        //   }
        // }
      }
    }
    async function postProduction() {
      // 使用者名稱及按讚高亮外加按鈕隱藏控制
      let items = document.querySelectorAll(".item");
      for (const item of items) {
        let reviewID = item.id;
        let isMyPost = await checkMyPost(reviewID);
        let isMyLike = await checkMyLike(reviewID);
        if (isMyPost) {
          let name = item.querySelector(".name");
          let postBtn = document.querySelector(".post-btn");
          name.style.backgroundColor = "#fbbc04";
          postBtn.style.display = "none";
        }
        if (isMyLike) {
          let like = item.querySelector(".like-btn img");
          like.setAttribute("src", "/static/images/like-filled.png");
        }
      }
      async function checkMyLike(reviewID) {
        let url = `/api/review/mylike/${reviewID}`;
        let init = {
          headers: {
            "Authorization": `Bearer ${token}`,
          },
        };
        let request = new Request(url, init);
        let res = await fetch(request);
        let resData = await res.json();
        if (resData !== null) {
          return true;
        } else {
          return false
        }
      }
      async function checkMyPost(reviewID) {
        let url = `/api/review/mypost/${reviewID}`;
        let init = {
          headers: {
            "Authorization": `Bearer ${token}`,
          },
        };
        let request = new Request(url, init);
        let res = await fetch(request);
        let resData = await res.json();
        if (resData !== null) {
          return true;
        } else {
          return false
        }
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
      if (resData) {
        alert("成功新增評論！");
      } else {
        alert("您已經給過評論了！")
      }
      location.reload();
    });
  }
}
