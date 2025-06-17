init();
async function init() {
  const token = localStorage.getItem("token");
  await checkSignin();
  loadList();
  setItemForm();
  setRemoveBtn();
  async function checkSignin() {
    let user = await getUser();
    if (user == null) {
      alert("請先登入系統");
      location.href = "/";
    }
    async function getUser() {
      let url = "/api/user";
      let request = new Request(url, {
        headers: { "Authorization": `Bearer ${token}` },
      });
      let res = await fetch(request);
      let resData = await res.json();
      let user = resData.user;
      return user;
    }
  }
  async function loadList() {
    let items = await getListItems();
    let list = document.querySelector(".list");
    while (list.lastChild) {
      list.lastChild.remove();
    }
    for (let item of items) {
      addItem(item);
    }
    window.scrollTo({
      top: 0,
      behavior: 'smooth'
    });
    async function getListItems() {
      let url = "/api/list";
      let request = new Request(url, {
        headers: {
          "Content-Type": "application/json", "Authorization": `Bearer ${token}`
        },
      });
      let res = await fetch(request);
      let resData = await res.json();
      let list = resData.list;
      let items = [];
      for (const elem of list) {
        let item = [];
        item.push(elem.id);
        item.push(elem.name);
        item.push(elem.note);
        item.push(elem.checked);
        items.push(item);
      }
      return items;
    }
  }
  function setItemForm() {
    let addBtn = document.querySelector(".add-item-btn");
    let closeBtn = document.querySelector(".close-btn");
    let itemForm = document.querySelector(".dialog-main form");
    addBtn.addEventListener("click", () => dialog("block"));
    closeBtn.addEventListener("click", () => dialog("none"));
    itemForm.addEventListener("submit", submitItemForm);
    function dialog(display) {
      document.querySelector(".mask").style.display = display;
      document.querySelector(".add-item-dialog").style.display = display;
      initForm();
      function initForm() {
        let form = document.querySelector(".add-item-dialog");
        let submitter = form.querySelector('[type="submit"]');
        let title = form.querySelector("h3");
        let inputName = form.querySelector('[name="item"]');
        let inputSpec = form.querySelector('[name="specs"]');
        title.textContent = "新增項目";
        title.removeAttribute("id");
        inputName.value = "";
        inputSpec.value = "";
        submitter.value = "加入清單";
      }
    }
    async function submitItemForm(event) {
      event.preventDefault();
      let title = document.querySelector(".dialog-main h3");
      let body = formToBody(this);
      let resData = await postList(body);
      if (resData.error) {
        let p = this.querySelector("p.message");
        p.innerText = resData.message;
        p.setAttribute("style", "display:block");
        return;
      }
      // 刪除編輯前的項目
      if (title.id) {
        await delItem(title.id);
      }
      dialog("none");
      loadList();
      function formToBody(form) {
        let submitter = form.querySelector("[type='submit']");
        let formData = new FormData(form, submitter);
        let body = {};
        for (let [key, value] of formData) {
          body[key] = value;
        }
        return body;
      }
      async function postList(body) {
        let url = "/api/list";
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
    }
  }
  function setRemoveBtn() {
    let rmvBtn = document.querySelector(".rmv-bought");
    rmvBtn.addEventListener("click", rmvItems);
    async function rmvItems() {
      if (!confirm("要清除已買項目嗎？")) {
        return;
      }
      let boxes = document.querySelectorAll('[type="checkbox"]');
      for (let box of boxes) {
        if (box.checked) {
          let itemId = box.parentElement.id;
          await delItem(itemId);
        }
      }
      // location.reload();
      loadList();
    }
  }
  function addItem(item) {
    let para = document.createElement("p");
    let box = document.createElement("input");
    let row = document.createElement("div");
    let list = document.querySelector(".list");
    let rmv = document.querySelector(".rmv-bought");
    para.className = "description";
    para.textContent = `${item[1]} ${item[2]}`;
    para.addEventListener("click", function () {
      // 改變表單內容
      let form = document.querySelector(".add-item-dialog");
      let submitter = form.querySelector('[type="submit"]');
      let title = form.querySelector("h3");
      let inputName = form.querySelector('[name="item"]');
      let inputSpec = form.querySelector('[name="specs"]');
      let preContent = this.textContent.split(" ");
      let productName = preContent.shift();
      let productSpec = preContent.join(" ");
      form.style.display = "block";
      title.textContent = "修改項目";
      title.id = item[0];
      inputName.value = productName;
      inputSpec.value = productSpec;
      submitter.value = "確認修改";
    });
    box.setAttribute("type", "checkbox");
    box.setAttribute("name", "bought");
    box.checked = item[3];
    box.addEventListener("click", function () {
      if (box.checked) {
        list.appendChild(this.parentElement);
        updateItemStatus(item[0], box.checked);
        rmv.style.display = "block";
      } else {
        list.prepend(this.parentElement);
        updateItemStatus(item[0], box.checked);
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
    async function updateItemStatus(itemId, bought) {
      let url = `/api/list`;
      let body = {
        "itemId": itemId,
        "bought": bought
      };
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
  }
  async function delItem(itemId) {
    let url = `/api/list/${itemId}`;
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
}