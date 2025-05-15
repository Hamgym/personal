async function postItem(form) {
  let submitter = form.querySelector(`[type="submit"]`);
  let formData = new FormData(form, submitter);
  let url = "/add-item";
  let init = {
    method: "POST",
    body: formData,
  };
  let request = new Request(url, init);
  let res = await fetch(request);
  let resData = await res.json();
  addItem(resData);
  return resData;
}
function addItem(resData) {
  let div = document.createElement("div");
  let input = document.createElement("input");
  let item = document.createElement("div");
  let list = document.querySelector(".list");
  div.className = "description";
  div.textContent = resData;
  div.addEventListener("click", function () {
    if (confirm(`${div.textContent}\n\n要刪除此項目嗎？`)) {
      this.parentElement.remove();
    }
  });
  input.setAttribute("type", "checkbox");
  input.setAttribute("name", "bought");
  input.addEventListener("click", function () {
    if (input.checked) {
      list.appendChild(this.parentElement);
    } else {
      list.prepend(this.parentElement);
    }
  });
  item.className = "item";
  item.appendChild(div);
  item.appendChild(input);
  list.appendChild(item);
}
function init() {
  addItem("麥香奶茶 300ml * 24 注意包裝完整性");
  addItem("可口可樂 2L");
  addItem("雀巢檸檬紅茶 600ml");
}


init();


let addBtn = document.querySelector(".add-item-btn");
let form = document.querySelector(".add-item");
let rmvBtn = document.querySelector(".remove-bought");
addBtn.addEventListener("click", function () {
  let form = document.querySelector(".add-item");
  if (form.style.display != "block") {
    form.style.display = "block";
  } else {
    form.style.display = "none";
  }
});
form.addEventListener("submit", async function (event) {
  event.preventDefault();
  await postItem(this);
  // addItem(resData);
  this.querySelector("[type='text']").value = "";
  this.style.display = "none";
});
form.querySelector(".cancel").addEventListener("click", function () {
  form.style.display = "none";
});
rmvBtn.addEventListener("click", async function () {
  if (!confirm("要移除已買項目嗎？")) {
    return;
  }
  let items = document.querySelectorAll(".item");
  for (let item of items) {
    let checkbox = item.querySelector("[type='checkbox']");
    if (checkbox.checked) {
      checkbox.parentElement.remove();
    }
  }
})