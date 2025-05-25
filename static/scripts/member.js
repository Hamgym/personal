init();
async function init() {
  const token = localStorage.getItem("token");
  await checkSignin();
  async function checkSignin() {
    let user = await getUser(token);
    let main = document.querySelector(".main");
    if (user == null) {
      alert("請先登入系統");
      location.href = "/";
    }
    main.textContent = `【${user.name}】歡迎回來！`;
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
}
