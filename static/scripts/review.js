const token = localStorage.getItem("token");


init();


async function init() {
  checkSignin();
  loadProducts();
  setDropdown();
  setAddProductDialog();
  setSearchForm();


  let url = "/api/product/category"
  let request = new Request(url, {
    headers: {
      "Authorization": `Bearer ${token}`
    },
  });
  let res = await fetch(request);
  let resData = await res.json();
  console.log(resData);




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
  async function loadProducts(keyword) {
    let url = "/api/product";
    if (!(keyword === undefined)) {
      url += `?keyword=${keyword}`;
    }
    let request = new Request(url, {
      headers: {
        "Content-Type": "application/json",
        "Authorization": `Bearer ${token}`
      },
    });
    let res = await fetch(request);
    let resData = await res.json();
    let data = resData.data;
    let main = document.querySelector(".main");
    while (main.firstChild) {
      main.firstChild.remove();
    }
    for (let item of data) {
      let product = document.createElement("div");
      product.id = item[0];
      product.className = "product";
      product.textContent = `【${item[2]}】${item[3]}`;
      main.appendChild(product);
    }

  }
  function setDropdown() {
    let dropdowns = document.querySelectorAll("div.dropdown");
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
  function setAddProductDialog() {
    let addProductBtn = document.querySelector("div.add-product-btn");
    let cancelBtn = document.querySelector(".add-product-dialog .cancel");

    addProductBtn.addEventListener("click", function () {
      let dialog = document.querySelector("div.add-product-dialog");
      dialog.style.display = "block";
    });
    cancelBtn.addEventListener("click", function () {
      let dialog = document.querySelector("div.add-product-dialog");
      dialog.style.display = "none";
    });

    let form = document.querySelector(".add-product-dialog form");
    form.addEventListener("submit", async function (event) {
      event.preventDefault();
      let submitter = form.querySelector('button[type="submit"]');
      let formData = new FormData(this, submitter);
      let url = "/api/product";
      let init = {
        headers: { "Authorization": `Bearer ${token}` },
        method: "POST",
        body: formData,
      };
      let request = new Request(url, init);
      let res = await fetch(request);
      let resData = await res.json();
      console.log(resData);
      let newProduct = resData.newProduct;
      if (newProduct) {
        // 將資訊代入搜尋欄位並搜尋
        alert("成功建立新產品！");
        location.href = "/review";
      } else {
        // 將資訊代入搜尋欄位並搜尋
        alert("該商品已經存在！");
      }
    });
  }
  function setSearchForm() {
    let searchForm = document.querySelector(".header form");
    searchForm.addEventListener("submit", async function (event) {
      event.preventDefault();
      let input = document.querySelector(".header input");
      let keyword = input.value;
      loadProducts(keyword);
    })
  }
}
