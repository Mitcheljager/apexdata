document.addEventListener("DOMContentLoaded", function() {
  const elements = document.querySelectorAll("[data-action='set-filter']")

  elements.forEach((element) => element.removeEventListener("click", setFilter))
  elements.forEach((element) => element.addEventListener("click", setFilter))
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
