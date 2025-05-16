const token = localStorage.getItem("token");


init();
addRow("麥香綠茶 300ml * 24 有多少買多少啦！");
addRow("杜老爺冰淇淋 桶裝");
addRow("肥宅快樂水 2L");


async function init() {
  let user = await getUser(token);
  let addBtn = document.querySelector(".add-item-btn");
  let closeBtn = document.querySelector(".close-btn");
  let itemForm = document.querySelector(".dialog-main form");

  if (user == null) {
    alert("請先登入系統");
    location.href = "/";
  }
  addBtn.addEventListener("click", () => dialog("block"));
  closeBtn.addEventListener("click", () => dialog("none"));
  itemForm.addEventListener("submit", async function (event) {
    event.preventDefault();
    let body = formToBody(this);
    let resData = await postList(token, body);
    if (resData.error) {
      let p = this.querySelector("p.message");
      p.innerText = resData.message;
      p.setAttribute("style", "display:block");
    }
    if (resData.ok) {
      let message = resData.message;
      let description = `${message.item} ${message.specs}`;
      this.querySelector('[name="item"]').value = "";
      this.querySelector('[name="specs"]').value = "";
      addRow(description);
      dialog("none");
    }
  });

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
  function dialog(display) {
    document.querySelector(".mask").style.display = display;
    document.querySelector(".add-item-dialog").style.display = display;
  }
}
function formToBody(form) {
  let submitter = form.querySelector("[type='submit']");
  let formData = new FormData(form, submitter);
  let body = {};
  for (let [key, value] of formData) {
    body[key] = value;
  }
  return body;
}
async function postList(token, body) {
  let url = "/api/lists";
  let request = new Request(url, {
    method: "POST",
    headers: {
      "Content-Type": "application/json", "Authorization": `Bearer ${token}`
    },
    body: JSON.stringify(body),
  });
  let res = await fetch(request);
  let resData = await res.json();
  return resData;
}
function addRow(description) {
  let para = document.createElement("p");
  let box = document.createElement("input");
  let row = document.createElement("div");
  let list = document.querySelector(".list");
  para.className = "description";
  para.textContent = description;
  para.addEventListener("click", function () {
    if (confirm(`${para.textContent}\n\n要刪除此項目嗎？`)) {
      this.parentElement.remove();
    }
  });
  box.setAttribute("type", "checkbox");
  box.setAttribute("name", "bought");
  box.addEventListener("click", function () {
    if (box.checked) {
      list.appendChild(this.parentElement);
    } else {
      list.prepend(this.parentElement);
    }
  });
  row.className = "row";
  row.appendChild(para);
  row.appendChild(box);
  list.appendChild(row);
}