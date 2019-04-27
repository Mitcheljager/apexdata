document.addEventListener("DOMContentLoaded", function() {
  const elements = document.querySelectorAll("[data-action='set-filter']")

  elements.forEach((element) => element.removeEventListener("click", setFilter))
  elements.forEach((element) => element.addEventListener("click", setFilter))

  const element = document.querySelector("[data-action='charts-filter']")
  if (element) element.addEventListener("submit", setChartFilter)
})

function setFilter(event) {
  event.preventDefault()

  const parentElement = this.closest("[data-role='filter']")
  const filterType = parentElement.querySelector("[data-target='filter-type']").value
  const filterSortBy = parentElement.querySelector("[data-target='filter-sort-by']").value

  if (!filterSortBy) {
    parentElement.querySelector("[data-target='filter-sort-by']").style.borderColor = "#b52626"
    return
  }

  window.location.href = `/sort/${ filterType }/${ filterSortBy }`
}

function setChartFilter(event) {
  event.preventDefault()

  const formData = new FormData(this)
  const fromFieldValue = formData.get("start_date")
  const toFieldValue = formData.get("end_date")
  const limitFieldValue = formData.get("limit")

  const currentPage = window.location.pathname
  const currentPageArray = currentPage.split("/")
  const currentPageStart = currentPageArray.slice(1, 5)
  const currentPageBasic = currentPageStart.join("/")

  if (fromFieldValue && toFieldValue && limitFieldValue)
    window.location.href = `/${ currentPageBasic }/${ fromFieldValue }/${ toFieldValue }/${ limitFieldValue }`
}
