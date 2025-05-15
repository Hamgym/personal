frontInit();
async function frontInit() {
  let user = null;
  let token = localStorage.getItem("token");
  if (token) {
    let url = "/api/user/auth";
    let request = new Request(url, {
      headers: { "Authorization": `Bearer ${token}` },
    });
    let res = await fetch(request);
    let resData = await res.json();
    user = resData.data;
  }


  let mask = document.querySelector("div.mask");
  let addBtn = document.querySelector(".add-item-btn");
  let closeBtns = document.querySelectorAll("div.close");
  let signinDialog = document.querySelector("div.signin-dialog");
  addBtn.addEventListener("click", function () {
    signinDialog.style.display = "block";
  });
  for (let closeBtn of closeBtns) {
    closeBtn.addEventListener("click", function () {
      mask.style.display = "none";
      signinDialog.style.display = "none";
    });
  }
  window.addEventListener("keydown", function (event) {
    if (event.key == "Escape") {
      mask.style.display = "none";
      signinDialog.style.display = "none";
    }
  });


  let signinForm = document.querySelector(".signin-main form");
  signinForm.addEventListener("submit", async function (event) {
    event.preventDefault();
    let submitter = signinForm.querySelector("[type='submit']");
    let formData = new FormData(this, submitter);
    let body = {};
    for (const [key, value] of formData) {
      body[key] = value;
    }
    let url = "/api/user/auth";
    let request = new Request(url, {
      method: "PUT",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(body),
    });
    let res = await fetch(request);
    let resData = await res.json();
    if (resData.error) {
      let p = signinForm.querySelector("p.message");
      p.innerText = resData.message;
      p.setAttribute("style", "display:block");
    } else {
      localStorage.setItem("token", resData.token);
      location.href = "/";
    }
  });
}