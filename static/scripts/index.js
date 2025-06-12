init();
async function init() {
	const token = localStorage.getItem("token");
	setSignBtn();
	setSigninDialog();
	setSignupDialog();
	async function setSignBtn() {
		let user = await getUser(token);
		if (user) {
			let signBtn = document.querySelector(".sign-btn");
			signBtn.innerText = "登出系統";
			signBtn.addEventListener("click", function () {
				localStorage.setItem("token", "");
				location.href = "/";
			});
		} else {
			let signBtn = document.querySelector(".sign-btn");
			signBtn.innerText = "登入/註冊";
			signBtn.addEventListener("click", function () {
				let mask = document.querySelector("div.mask");
				let signinDialog = document.querySelector("div.signin-dialog");
				mask.style.display = "block";
				signinDialog.style.display = "block";
			});
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
	async function setSigninDialog() {
		let closeBtn = document.querySelector(".signin-dialog .close");
		let signupLink = document.querySelector(".signin-main div.signup");
		let signinForm = document.querySelector(".signin-main form");
		closeBtn.addEventListener("click", function () {
			let mask = document.querySelector("div.mask");
			let signinDialog = document.querySelector("div.signin-dialog");
			let signupDialog = document.querySelector("div.signup-dialog");
			mask.style.display = "none";
			signinDialog.style.display = "none";
			signupDialog.style.display = "none";
		});
		signupLink.addEventListener("click", function () {
			let signinDialog = document.querySelector("div.signin-dialog");
			let signupDialog = document.querySelector("div.signup-dialog");
			signinDialog.style.display = "none";
			signupDialog.style.display = "block";
		});
		signinForm.addEventListener("submit", async function (event) {
			event.preventDefault();
			let submitter = signinForm.querySelector("[type='submit']");
			let formData = new FormData(this, submitter);
			let body = {};
			for (const [key, value] of formData) {
				body[key] = value;
			}
			let url = "/api/user/auth";
			let request = new Request(url, {
				method: "PUT",
				headers: { "Content-Type": "application/json" },
				body: JSON.stringify(body),
			});
			let res = await fetch(request);
			let resData = await res.json();
			if (resData.error) {
				let p = signinForm.querySelector("p.message");
				p.innerText = resData.message;
				p.setAttribute("style", "display:block");
			} else {
				localStorage.setItem("token", resData.token);
				location.href = "/member";
			}
		});
	}
	async function setSignupDialog() {
		let closeBtn = document.querySelector(".signup-dialog .close");
		let signinLink = document.querySelector(".signup-main div.signin");
		let signupForm = document.querySelector(".signup-main form");
		closeBtn.addEventListener("click", function () {
			let mask = document.querySelector("div.mask");
			let signinDialog = document.querySelector("div.signin-dialog");
			let signupDialog = document.querySelector("div.signup-dialog");
			mask.style.display = "none";
			signinDialog.style.display = "none";
			signupDialog.style.display = "none";
		});
		signinLink.addEventListener("click", function () {
			let signinDialog = document.querySelector("div.signin-dialog");
			let signupDialog = document.querySelector("div.signup-dialog");
			signinDialog.style.display = "block";
			signupDialog.style.display = "none";
		});
		signupForm.addEventListener("submit", async function (event) {
			event.preventDefault();
			let submitter = signupForm.querySelector("[type='submit']");
			let formData = new FormData(this, submitter);
			let body = {};
			for (const [key, value] of formData) {
				body[key] = value;
			}
			let url = "/api/user";
			let request = new Request(url, {
				method: "POST",
				headers: { "Content-Type": "application/json" },
				body: JSON.stringify(body),
			});
			let res = await fetch(request);
			let resData = await res.json();
			let p = signupForm.querySelector("p.message");
			p.setAttribute("style", "display: block");
			p.innerText = resData.message;
		});
	}
}