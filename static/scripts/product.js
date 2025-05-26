const token = localStorage.getItem("token");

init();

async function init() {
  await checkSignin();
  // loadProduct();
  setSearchForm();
  setDropdownSwitch();
  setDropdownContent();
  setAddProductBtn();
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
      product.addEventListener("click", function () {
        location.href = `/review/${product.id}`;
      });
    }
  }
  function setSearchForm() {
    let searchForm = document.querySelector(".header form");
    searchForm.addEventListener("submit", async function (event) {
      event.preventDefault();
      let input = document.querySelector(".header input");
      let keyword = input.value;
      loadProduct(keyword);
      resetBtns()
      setDropdownContent();
      function resetBtns() {
        let categoryTitle = document.querySelector(".category span");
        let brandTitle = document.querySelector(".brand span");
        categoryTitle.textContent = "類別";
        brandTitle.textContent = "品牌";
      }
    });
  }
  function setDropdownSwitch() {
    let categoryDropdown = document.querySelector("div.category");
    let categoryContent = categoryDropdown.querySelector("div.category");
    let brandDropdown = document.querySelector("div.brand");
    let brandContent = brandDropdown.querySelector("div.brand");
    categoryDropdown.addEventListener("click", function () {
      if (categoryContent.style.display == "none") {
        categoryContent.style.display = "flex";
        brandContent.style.display = "none";
      } else {
        categoryContent.style.display = "none";
      }
    });
    brandDropdown.addEventListener("click", function () {
      if (brandContent.style.display == "none") {
        brandContent.style.display = "flex";
        categoryContent.style.display = "none";
      } else {
        brandContent.style.display = "none";
      }
    });
  }
  function setDropdownContent() {
    categoryFilter();
    brandFilter();
    async function categoryFilter() {
      let keyword = document.querySelector(".header input").value;
      let brand = document.querySelector(".brand span").textContent;
      let url = `/api/product/category?keyword=${keyword}&brand=${brand}`;
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
          setDropdownContent();
          resetBrandTitle();
          function resetBrandTitle() {
            document.querySelector(".brand span").textContent = "品牌";
          }
        });
      }
    }
    async function brandFilter() {
      let keyword = document.querySelector(".header input").value;
      let category = document.querySelector(".category span").textContent;
      let url = `/api/product/brand?keyword=${keyword}&category=${category}`;
      let request = new Request(url, {
        headers: {
          "Authorization": `Bearer ${token}`
        },
      });
      let res = await fetch(request);
      let resData = await res.json();
      let data = resData.data;
      let brandList = document.querySelector(".dropdown-content.brand");
      while (brandList.firstChild) {
        brandList.firstChild.remove();
      }
      for (const brand of data) {
        let item = document.createElement("div");
        let span = document.createElement("span");
        let text = document.createTextNode(`(${brand[1]})`);
        item.className = "item";
        span.textContent = brand[0];
        item.appendChild(span);
        item.appendChild(text);
        brandList.appendChild(item);
        item.addEventListener("click", function () {
          let category = document.querySelector(".category span").textContent;
          let brand = item.querySelector("span").textContent;
          let keyword = document.querySelector(".header input").value;
          let title = document.querySelector(".brand span");
          title.textContent = brand;
          loadProduct(keyword, category, brand);
          setDropdownContent();
        });
      }
    }
  }
  function setAddProductBtn() {
    let addProductBtn = document.querySelector("div.add-product-btn");
    let cancelBtn = document.querySelector(".add-product-dialog .close-btn");
    let form = document.querySelector(".add-product-dialog form");
    let mask = document.querySelector(".mask");
    addProductBtn.addEventListener("click", function () {
      let dialog = document.querySelector("div.add-product-dialog");
      dialog.style.display = "block";
      mask.style.display = "block";
    });
    cancelBtn.addEventListener("click", function () {
      let dialog = document.querySelector("div.add-product-dialog");
      dialog.style.display = "none";
      mask.style.display = "none";
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
      let newProduct = resData.newProduct;
      if (newProduct) {
        alert("成功建立新產品！");
        location.href = "/product";
      } else {
        alert("該商品已經存在！");
        // 代入資料並搜尋
      }
    });
  }
}
