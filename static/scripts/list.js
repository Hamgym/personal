const token = localStorage.getItem("token");


init();


async function init() {
  let user = await getUser(token);
  let addBtn = document.querySelector(".add-item-btn");
  let closeBtn = document.querySelector(".close-btn");
  let itemForm = document.querySelector(".dialog-main form");


  signinCheck(user);
  loadList(token);
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
      let id = resData.id;
      let item = await getListItem(token, id);
      addRow(item);
      dialog("none");
      this.querySelector('[name="item"]').value = "";
      this.querySelector('[name="specs"]').value = "";
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
  async function loadList(token) {
    let items = await getList(token);
    for (let item of items) {
      addRow(item);
    }
  }
  function dialog(display) {
    document.querySelector(".mask").style.display = display;
    document.querySelector(".add-item-dialog").style.display = display;
  }
  function signinCheck(user) {
    if (user == null) {
      alert("請先登入系統");
      location.href = "/";
    }
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
async function getList(token) {
  let url = "/api/lists";
  let request = new Request(url, {
    headers: {
      "Content-Type": "application/json", "Authorization": `Bearer ${token}`
    },
  });
  let res = await fetch(request);
  let resData = await res.json();
  let items = resData.data;
  return items;
}
async function getListItem(token, itemId) {
  let url = `/api/lists/${itemId}`;
  let request = new Request(url, {
    headers: {
      "Content-Type": "application/json", "Authorization": `Bearer ${token}`
    },
  });
  let res = await fetch(request);
  let resData = await res.json();
  let item = resData.data;
  return item;
}
function addRow(item) {
  let para = document.createElement("p");
  let box = document.createElement("input");
  let row = document.createElement("div");
  let list = document.querySelector(".list");
  para.className = "description";
  para.textContent = `${item[1]} ${item[2]}`;
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
  row.id = item[0];
  row.appendChild(para);
  row.appendChild(box);
  list.appendChild(row);
}