init();
async function init() {
  const token = localStorage.getItem("token");
  await checkSignin();
  showReviewCount();
  async function checkSignin() {
    let user = await getUser(token);
    let welcome = document.querySelector(".welcome");
    if (user == null) {
      alert("請先登入系統");
      location.href = "/";
    }
    welcome.textContent = `【${user.name}】歡迎回來！`;
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
  async function showReviewCount() {
    let reviewCountDiv = document.querySelector(".review-count");
    let url = "/api/review/count";
    let request = new Request(url, {
      headers: { "Authorization": `Bearer ${token}` },
    });
    let res = await fetch(request);
    let resData = await res.json();
    let count = resData.myReviewCount;
    reviewCountDiv.textContent = `您已留下 ${count} 則評論`;
    showLikeCount(resData.likeCount);
    async function showLikeCount(count) {
      let likeCountDiv = document.querySelector(".like-count");
      // let url = "/api/review/like/count";
      // let request = new Request(url, {
      //   headers: { "Authorization": `Bearer ${token}` },
      // });
      // let res = await fetch(request);
      // let resData = await res.json();
      // let count = resData.likeCount;
      likeCountDiv.textContent = `並獲得 ${count} 個讚`;
    }
  }
}
