document.addEventListener("turbolinks:load", function() {
  const elements = document.querySelectorAll("[data-action='expand-item']")

  elements.forEach((element) => element.removeEventListener("click", expandItem))
  elements.forEach((element) => element.addEventListener("click", expandItem))
})

function expandItem(event) {
  event.preventDefault()

  const parentElement = this.closest(".item")
  parentElement.classList.toggle("item--compact")
}
