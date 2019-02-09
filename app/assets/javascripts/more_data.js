document.addEventListener("turbolinks:load", function() {
  const elements = document.querySelectorAll("[data-action='item-more-data']")

  elements.forEach((element) => element.removeEventListener("click", moreDetails))
  elements.forEach((element) => element.addEventListener("click", moreDetails))
})

function moreDetails() {
  event.preventDefault()

  const parentElement = this.closest(".item")
  parentElement.classList.toggle("item--more-data")

  this.classList.toggle("button--primary")
  if (this.innerHTML == "More data") {
    this.innerHTML = "Less data"
  } else {
    this.innerHTML = "More data"
  }
}