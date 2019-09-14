document.addEventListener("DOMContentLoaded", function() {
  const elements = document.querySelectorAll("[data-action='toggle']")

  elements.forEach((element) => element.removeEventListener("click", toggleElement))
  elements.forEach((element) => element.addEventListener("click", toggleElement))
})

function toggleElement(event) {
  event.preventDefault()

  const target = this.dataset.target
  const targetElements = document.querySelectorAll(`[data-is=${ target }]`)

  targetElements.forEach(element => {
    const display = (window.getComputedStyle ? getComputedStyle(element, null) : element.currentStyle).display
    if (display == "none") {
      element.style.display = "block";
    } else {
      element.style.display = "none";
    }
  })
}
