const token = localStorage.getItem("token");


init();


async function init() {
  let user = await getUser(token);
  let addBtn = document.querySelector(".add-item-btn");
  let closeBtn = document.querySelector(".close-btn");
  let itemForm = document.querySelector(".dialog-main form");
  let rmvBtn = document.querySelector(".rmv-bought");


  signinCheck(user);
  loadList(token);
  addBtn.addEventListener("click", () => dialog("block"));
  closeBtn.addEventListener("click", () => dialog("none"));
  itemForm.addEventListener("submit", submitItemForm);
  rmvBtn.addEventListener("click", rmvItems);


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
  async function submitItemForm(event) {
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
  }
  async function rmvItems() {
    if (!confirm("要清除已買項目嗎？")) {
      return;
    }
    let boxes = document.querySelectorAll('[type="checkbox"]');
    for (let box of boxes) {
      if (box.checked) {
        let itemId = box.parentElement.id;
        delListItem(token, itemId);
        location.href = "/list";
      }
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
  function formToBody(form) {
    let submitter = form.querySelector("[type='submit']");
    let formData = new FormData(form, submitter);
    let body = {};
    for (let [key, value] of formData) {
      body[key] = value;
    }
    return body;
  }
  function addSomeItems() {
    let list = [];
    list.push(["牙周適", "經典配方"]);
    list.push(["橄欖油", "奧利塔"]);
    list.push(["棉花棒", "盒裝"]);
    list.push(["純喫茶紅茶", "650ml * 2"]);
    list.push(["大豆沙拉油", "2L 台糖"]);
    for (const [item, specs] of list) {
      let body = {};
      body.item = item;
      body.specs = specs;
      postList(token, body);
    }
  }
}
async function postList(token, body) {
  let url = "/api/lists";
  let request = new Request(url, {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
      "Authorization": `Bearer ${token}`
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
async function delListItem(token, itemId) {
  let url = `/api/lists/${itemId}`;
  let request = new Request(url, {
    method: "DELETE",
    headers: {
      "Authorization": `Bearer ${token}`
    },
  });
  let res = await fetch(request);
  let resData = await res.json();
  return resData;
}
async function updateListItem(token, itemId, bought) {
  let url = `/api/lists/${itemId}`;
  let body = { "bought": bought };
  let request = new Request(url, {
    method: "PATCH",
    headers: {
      "Authorization": `Bearer ${token}`,
      "Content-Type": "application/json",
    },
    body: JSON.stringify(body),
  });
  let res = await fetch(request);
  let resData = await res.json();
  return resData;
}
function addRow(item) {
  let para = document.createElement("p");
  let box = document.createElement("input");
  let row = document.createElement("div");
  let list = document.querySelector(".list");
  let rmv = document.querySelector(".rmv-bought");
  para.className = "description";
  para.textContent = `${item[1]} ${item[2]}`;
  para.addEventListener("click", function () {
    if (confirm(`${para.textContent}\n\n要刪除此項目嗎？`)) {
      delListItem(token, item[0]);
      this.parentElement.remove();
      displayRmvBtn();
    }
  });
  box.setAttribute("type", "checkbox");
  box.setAttribute("name", "bought");
  box.checked = item[3];
  box.addEventListener("click", function () {
    if (box.checked) {
      list.appendChild(this.parentElement);
      updateListItem(token, item[0], box.checked);
      rmv.style.display = "block";
    } else {
      list.prepend(this.parentElement);
      updateListItem(token, item[0], box.checked);
      displayRmvBtn();
    }
  });
  row.className = "row";
  row.id = item[0];
  row.appendChild(para);
  row.appendChild(box);
  if (box.checked) {
    list.appendChild(row);
    rmv.style.display = "block";
  } else {
    list.prepend(row);
  }
  function displayRmvBtn() {
    let rows = document.querySelectorAll(".row");
    let flag = false;
    for (let row of rows) {
      let checked = row.querySelector("input").checked;
      if (checked) {
        flag = true;
        break;
      }
    }
    if (flag) {
      rmv.style.display = "block";
    } else {
      rmv.style.display = "none";
    }
  }
}