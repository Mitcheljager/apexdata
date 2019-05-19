function fetchApiData(url) {
  fetch(url, {
    method: "GET",
    headers: {
      "contentType": "application/json; charset=utf-8",
      "X-Requested-With": "XMLHttpRequest",
      "X-CSRF-Token": Rails.csrfToken()
    }
  }).then((response) => {
    response.text().then(content =>  {
      document.querySelector("[data-role='profile-content']").innerHTML = content

      createCharts()
      bindCharts()
      bindPopops()
      bindFetchApiData()
      bindForms()
      bindPlatforms()
    })
  })
}

function bindFetchApiData() {
  const elements = document.querySelectorAll("[data-action='fetch-api-data']")

  elements.forEach((element) => element.addEventListener("click", fetchApiDataByClick))
}

function fetchApiDataByClick(event) {
  event.preventDefault()

  if (this.getAttribute("disabled") == "disabled") return

  this.innerHTML = "Updating..."
  this.setAttribute("disabled", "disabled")

  fetchApiData(this.dataset.url)
}
