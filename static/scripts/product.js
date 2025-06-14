init();
async function init() {
  const token = localStorage.getItem("token");
  await checkSignin();
  loadProduct();
  setSearchForm();
  setDropdownSwitch();
  resetDropdownContent();
  setAddProductBtn();
  setPersonalBtn();
  setSortBtn();
  async function checkSignin() {
    let user = await getUser(token);
    if (user == null) {
      alert("請先登入系統");
      location.href = "/";
    }
    async function getUser(token) {
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
  async function loadProduct(keyword = "", category = "", brand = "", sort = "id") {
    let dataList = await loadData();
    renderPage(dataList);
    async function loadData() {
      let personal = document.querySelector("#personal").checked;
      let url = `/api/product?keyword=${keyword}&category=${category}&brand=${brand}&sort=${sort}&personal=${personal}`;
      let request = new Request(url, {
        headers: {
          "Content-Type": "application/json",
          "Authorization": `Bearer ${token}`
        },
      });
      let res = await fetch(request);
      let resData = await res.json();
      let products = resData.products;
      let dataList = [];
      for (const product of products) {
        let row = [];
        row.push(product.productID);
        row.push(product.category);
        row.push(product.brand);
        row.push(product.productName);
        row.push(product.imgaeURL);
        row.push(product.ratingPercent);
        row.push(product.reviewCount);
        row.push(product.isListed);
        dataList.push(row);
      }
      return dataList;
    }
    function renderPage(dataList) {
      let main = document.querySelector(".main");
      while (main.firstChild) {
        main.firstChild.remove();
      }
      for (const data of dataList) {
        let product = document.querySelector(".copy .product").cloneNode(true);
        let addListBtn = product.querySelector(".add-list-btn");
        product.id = data[0];
        product.querySelector("img").src = data[4];
        product.querySelector("h3").textContent = `【${data[2]}】${data[3]}`;
        product.querySelector(".value").style.width = `${data[5]}%`;
        product.querySelector(".caption span").textContent = data[6];
        product.addEventListener("click", function (event) {
          // if (!["describes"].includes(event.target.className)) {
          //   location.href = `/review/${product.id}`;
          // }
          location.href = `/review/${product.id}`;
        });
        if (data[7]) {
          let addListIcon = addListBtn.querySelector("img");
          addListIcon.className = "added";
          addListIcon.src = "/static/images/add-new-filled-icon.png";
        }
        addListBtn.addEventListener("click", async function (event) {
          event.stopPropagation();
          if (event.target.className == "added") {
            return;
          }
          event.target.className = "added";
          event.target.src = "/static/images/add-new-filled-icon.png";
          let productID = product.id;
          let productName = product.querySelector("h3").textContent;
          let url = "/api/lists";
          let body = { item: productName, productID: productID };
          let request = new Request(url, {
            method: "POST",
            headers: {
              "Content-Type": "application/json",
              "Authorization": `Bearer ${token}`,
            },
            body: JSON.stringify(body),
          });
          let res = await fetch(request);
        });
        main.appendChild(product);
      }
      window.scrollTo({
        top: 0,
        behavior: 'smooth'
      });
    }
  }
  function setSearchForm() {
    let searchForm = document.querySelector(".header form");
    let clearBtn = document.querySelector("img.clear-search");
    let input = document.querySelector("#keyword");
    searchForm.addEventListener("submit", async function (event) {
      event.preventDefault();
      let keyword = document.querySelector(".header input").value;
      loadProduct(keyword);
      resetDropdownBtns();
      resetClearBtn();
      function resetClearBtn() {
        if (keyword.length > 0) {
          clearBtn.style.display = "block";
        } else {
          clearBtn.style.display = "none";
        }
      }
    });
    clearBtn.addEventListener("click", function () {
      clearBtn.style.display = "none";
      input.value = "";
      loadProduct();
      resetDropdownBtns();
    });
    input.addEventListener("input", async function () {
      let query = input.value;
      let suggestionsDiv = document.querySelector("#suggestions");
      if (query.length < 1) {
        suggestionsDiv.innerHTML = "";
        document.querySelector("img.clear-search").style.display = "none";
        loadProduct();
        resetDropdownBtns();
        return;
      }
      let res = await fetch(`/api/product/suggest?q=${encodeURIComponent(query)}`);
      let suggestions = await res.json();
      if (suggestionsDiv.firstChild) {
        suggestionsDiv.innerHTML = "";
      }
      for (const item of suggestions) {
        if (suggestionsDiv.children.length >= 6) {
          break;
        }
        let div = document.createElement('div');
        div.textContent = item;
        div.addEventListener("click", function () {
          let searchBtn = document.querySelector('.header [type="submit"]');
          suggestionsDiv.innerHTML = "";
          input.value = item;
          searchBtn.click();
        });
        suggestionsDiv.appendChild(div);
      }
    });
    input.addEventListener("change", function () {
      let value = input.value.trim();
      let history = JSON.parse(localStorage.getItem("searchHistory")) || [];
      if (value && !history.includes(value)) {
        history.unshift(value);
        if (history.length > 6) history.pop(); // 限制最多6筆
        localStorage.setItem("searchHistory", JSON.stringify(history));
      }
    });
    input.addEventListener("click", async function () {
      if (this.value) {
        let query = document.querySelector("#keyword").value;
        let suggestionsDiv = document.querySelector("#suggestions");
        let res = await fetch(`/api/product/suggest?q=${encodeURIComponent(query)}`);
        let suggestions = await res.json();
        if (suggestionsDiv.firstChild) {
          suggestionsDiv.innerHTML = "";
        }
        for (const item of suggestions) {
          if (suggestionsDiv.children.length >= 6) {
            break;
          }
          let div = document.createElement('div');
          div.textContent = item;
          div.onclick = () => {
            let searchBtn = document.querySelector('.header [type="submit"]');
            this.value = item;
            suggestionsDiv.innerHTML = "";
            searchBtn.click();
          };
          suggestionsDiv.appendChild(div);
        }
        return;
      }
      let suggestionsDiv = document.querySelector("#suggestions");
      let history = JSON.parse(localStorage.getItem("searchHistory")) || [];
      let suggestions = history;
      suggestionsDiv.innerHTML = "";
      for (const item of suggestions) {
        let div = document.createElement('div');
        div.textContent = item;
        div.onclick = () => {
          this.value = item;
          let searchBtn = document.querySelector('.header [type="submit"]');
          suggestionsDiv.innerHTML = "";
          searchBtn.click();
        };
        let img = document.createElement("img");
        img.src = "/static/images/close-bord.png";
        img.addEventListener("click", (event) => {
          event.stopPropagation();
          let row = event.target.parentElement;
          let word = row.textContent;
          let history = JSON.parse(localStorage.getItem("searchHistory"));
          history = history.filter((item) => item != word);
          localStorage.setItem("searchHistory", JSON.stringify(history));
          row.remove();
        });
        div.appendChild(img);
        suggestionsDiv.appendChild(div);
        if (suggestionsDiv.children.length >= 6) {
          break;
        }
      }
    });
    window.addEventListener("click", function (event) {
      let list = ["suggestions", "keyword"];
      if (list.includes(event.target.id)) return;
      document.querySelector("#suggestions").innerHTML = "";
    });
    function resetDropdownBtns() {
      let categoryTitle = document.querySelector(".category span");
      let brandTitle = document.querySelector(".brand span");
      categoryTitle.textContent = "類別";
      brandTitle.textContent = "品牌";
      resetDropdownContent();
    }
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
    window.addEventListener("click", function (event) {
      let className = event.target.className;
      let list = ["title", "icon", "dropdown-btn category", "dropdown-btn brand"];
      if (list.includes(className)) return;
      categoryContent.style.display = "none";
      brandContent.style.display = "none";
    });
  }
  function resetDropdownContent() {
    categoryFilter();
    brandFilter();
    async function categoryFilter() {
      let data = await getCategoryData();
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
        item.addEventListener("click", function () {
          let category = item.querySelector("span").textContent;
          let keyword = document.querySelector(".header input").value;
          let title = document.querySelector(".category span");
          title.textContent = category;
          loadProduct(keyword, category);
          resetDropdownContent();
          resetBrandTitle();
          function resetBrandTitle() {
            document.querySelector(".brand span").textContent = "品牌";
          }
        });
        categoryList.appendChild(item);
      }
      async function getCategoryData() {
        let keyword = document.querySelector(".header input").value;
        let personal = document.querySelector("#personal").checked;
        let url = `/api/product/category?keyword=${keyword}&personal=${personal}`;
        let request = new Request(url, {
          headers: {
            "Authorization": `Bearer ${token}`
          },
        });
        let res = await fetch(request);
        let resData = await res.json();
        let categories = resData.categories;
        let categoryList = [];
        for (const category of categories) {
          let item = [];
          item.push(category.category);
          item.push(category.productCount);
          categoryList.push(item);
        }
        return categoryList;
      }
    }
    async function brandFilter() {
      let data = await getBrandData();
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
          resetDropdownContent();
        });
      }
      async function getBrandData() {
        let keyword = document.querySelector(".header input").value;
        let category = document.querySelector(".category span").textContent;
        let personal = document.querySelector("#personal").checked;
        let url = `/api/product/brand?keyword=${keyword}&category=${category}&personal=${personal}`;
        let request = new Request(url, {
          headers: {
            "Authorization": `Bearer ${token}`
          },
        });
        let res = await fetch(request);
        let resData = await res.json();
        let data = resData.data;
        return data;
      }
    }
  }
  function setAddProductBtn() {
    let addProductBtn = document.querySelector("div.add-product-btn");
    let cancelBtn = document.querySelector(".add-product-dialog .close-btn");
    let fileInput = document.querySelector("#photo");
    let form = document.querySelector(".add-product-dialog form");
    addProductBtn.addEventListener("click", function () {
      let dialog = document.querySelector("div.add-product-dialog");
      let mask = document.querySelector(".mask");
      dialog.style.display = "block";
      mask.style.display = "block";
      let category = document.querySelector(".category span.title").textContent;
      if (category == "類別") category = "";
      let brand = document.querySelector(".brand span.title").textContent;
      if (brand == "品牌") brand = "";
      form.querySelector("#category").value = category;
      form.querySelector("#brand").value = brand;
    });
    cancelBtn.addEventListener("click", function () {
      let dialog = document.querySelector("div.add-product-dialog");
      let mask = document.querySelector(".mask");
      dialog.style.display = "none";
      mask.style.display = "none";
    });
    fileInput.addEventListener("change", function () {
      let label = document.querySelector('[for="photo"]');
      if (fileInput.value == "") {
        label.textContent = "上傳商品照片";
        return;
      }
      let filename = fileInput.value.split("\\")[2];
      let filesize = fileInput.files[0].size;
      if (filesize > 1 * 1024 * 1024) {
        alert("檔案太大，請選擇小於 1MB 的檔案。");
        fileInput.value = "";
        label.textContent = "上傳商品照片";
        return;
      }
      label.textContent = filename;
    });
    form.addEventListener("submit", async function (event) {
      event.preventDefault();
      let resData = await postNewProduct();
      if (resData.ok) {
        alert(`${resData.message}`);
        location.href = "/product";
      } else {
        alert(`${resData.message}`);
        // 可進一步代入資料並搜尋
      }
      async function postNewProduct() {
        let submitter = form.querySelector('button[type="submit"]');
        let formData = new FormData(form, submitter);
        let url = "/api/product";
        let init = {
          method: "POST",
          headers: { "Authorization": `Bearer ${token}` },
          body: formData,
        };
        let request = new Request(url, init);
        let res = await fetch(request);
        let resData = await res.json();
        return resData;
      }
    });
  }
  function setPersonalBtn() {
    let checkBox = document.querySelector("#personal");
    checkBox.addEventListener("change", function () {
      let icon = document.querySelector("img.personal");
      let searchBtn = document.querySelector(".header button");
      let keyword = document.querySelector("#keyword");
      let addProductBtn = document.querySelector("div.add-product-btn");
      if (this.checked) {
        icon.src = "/static/images/user-checked.png";
        keyword.value = "";
        searchBtn.click();
        showAlertBox("個人模式");
        addProductBtn.style.display = "none";
      } else {
        icon.src = "/static/images/user-unchecked.png";
        keyword.value = "";
        searchBtn.click();
        showAlertBox("一般模式");
        addProductBtn.style.display = "block";
      }
      function showAlertBox(text = "") {
        let header = document.querySelector(".header");
        let alertBox = document.querySelector(".alert").cloneNode(true);
        alertBox.textContent = text;
        alertBox.style.display = "flex";
        alertBox.style.right = "55px";
        alertBox.style.width = "120px";
        alertBox.className += " fade";
        header.appendChild(alertBox);
        setTimeout(() => {
          alertBox.remove();
        }, 3000);
      }
    });
  }
  function setSortBtn() {
    let btn = document.querySelector(".header .sort");
    let count = 0;
    let sortList = ["percent", "review", "id"];
    let alertList = ["評價排序", "評論數量排序", "新商品排序"];
    btn.addEventListener("click", function () {
      let sort = sortList[count];
      let alert = alertList[count];
      let keyword = document.querySelector(".search-row input").value;
      let category = document.querySelector(".category span").textContent;
      let brand = document.querySelector(".brand span").textContent;
      let alertBox = document.querySelector(".alert").cloneNode(true);
      let header = document.querySelector(".header");
      count += 1;
      count %= 3;
      loadProduct(keyword, category, brand, sort);
      alertBox.textContent = alert;
      alertBox.style.display = "flex";
      alertBox.className += " fade";
      header.appendChild(alertBox);
      setTimeout(() => {
        alertBox.remove();
      }, 3000);
    });
  }
}