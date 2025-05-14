let addBtn = document.querySelector(".add-item-btn");
addBtn.addEventListener("click", function () {
	let form = document.querySelector(".add-item");
	if (form.style.display != "block") {
		form.style.display = "block";
	} else {
		form.style.display = "none";
	}
});


let form = document.querySelector(".add-item");
form.addEventListener("submit", async function (event) {
	event.preventDefault();

	let submitter = this.querySelector(`[type="submit"]`);
	let formData = new FormData(this, submitter);
	let url = "/add-item";
	let init = {
		method: "POST",
		body: formData,
	};
	let request = new Request(url, init);
	let res = await fetch(request);
	let resData = await res.json();
	// console.log(resData);

	let div = document.createElement("div");
	let input = document.createElement("input");
	let item = document.createElement("div");
	let list = document.querySelector(".list");
	div.className = "description";
	div.textContent = resData;
	div.addEventListener("click", function () {
		if (confirm("要刪除此項目嗎？")) {
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

	this.querySelector("[type='text']").value = "";
	this.style.display = "none";
});
form.querySelector(".cancel").addEventListener("click", function () {
	form.style.display = "none";
});
