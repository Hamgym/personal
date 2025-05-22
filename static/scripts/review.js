const token = localStorage.getItem("token");
let initialized = false;


init();


async function init() {
  checkSignin();
  loadProduct();
  setDropdown();
  setAddProduct();
  setSearchForm();
  initialized = true;




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
  async function loadProduct(keyword = "", category = "", brand = "") {
    let url = `/api/product?keyword=${keyword}&category=${category}&brand=${brand}`;
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
  async function setDropdown(keyword = "") {
    resetBtns();
    displayContent();
    categoryFilter(keyword);

    function resetBtns() {
      let categoryTitle = document.querySelector(".category span");
      // let brandTitle = document.querySelector("")
      categoryTitle.textContent = "類別";

    }
    function displayContent() {
      let dropdowns = document.querySelectorAll("div.dropdown");
      if (initialized) {
        return;
      }
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
    async function categoryFilter(keyword = "") {
      let url = `/api/product/category?keyword=${keyword}`
      let request = new Request(url, {
        headers: {
          "Authorization": `Bearer ${token}`
        },
      });
      let res = await fetch(request);
      let resData = await res.json();
      let data = resData.data;
      let categoryList = document.querySelector(".dropdown-content.category");
      while (categoryList.firstChild) {
        categoryList.firstChild.remove();
      }
      for (const category of data) {
        let item = document.createElement("div");
        let span = document.createElement("span");
        let text = document.createTextNode(`(${category[1]})`);
        item.className = "item";
        span.textContent = category[0];
        item.appendChild(span);
        item.appendChild(text);
        categoryList.appendChild(item);
        item.addEventListener("click", function () {
          let category = item.querySelector("span").textContent;
          let keyword = document.querySelector(".header input").value;
          let title = document.querySelector(".category span");
          title.textContent = category;
          loadProduct(keyword, category);
        });
      }
    }
  }
  function setAddProduct() {
    let addProductBtn = document.querySelector("div.add-product-btn");
    let cancelBtn = document.querySelector(".add-product-dialog .cancel");
    let form = document.querySelector(".add-product-dialog form");

    addProductBtn.addEventListener("click", function () {
      let dialog = document.querySelector("div.add-product-dialog");
      dialog.style.display = "block";
    });
    cancelBtn.addEventListener("click", function () {
      let dialog = document.querySelector("div.add-product-dialog");
      dialog.style.display = "none";
    });
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
      loadProduct(keyword);
      setDropdown(keyword);
    })
  }
}
