document.addEventListener("DOMContentLoaded", function() {
  const elements = document.querySelectorAll("[data-action='toggle-popup']")

  elements.forEach(element => element.addEventListener("click", togglePopup))
})

function togglePopup(event) {
  event.preventDefault()

  const target = this.dataset.target
  const element = target ? document.querySelector(`[data-popup="${ target }"]`) : this.closest("[data-popup]")

  element.classList.toggle("active")
}
