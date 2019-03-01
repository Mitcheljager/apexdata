document.addEventListener("DOMContentLoaded", function() {
  const elements = document.querySelectorAll("[data-action='theme-switch']")

  elements.forEach((element) => element.removeEventListener("click", switchTheme))
  elements.forEach((element) => element.addEventListener("click", switchTheme))
})

function switchTheme(event) {
  event.preventDefault()

  const target = document.body

  if (target.classList.contains("theme-light")) {
    target.classList.remove("theme-light")
    this.classList.remove("theme-switch--light")

    document.cookie = "theme=theme_dark"
  } else {
    target.classList.add("theme-light")
    this.classList.add("theme-switch--light")

    document.cookie = "theme=theme_light"
  }
}
