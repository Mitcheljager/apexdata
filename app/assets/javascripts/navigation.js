document.addEventListener("DOMContentLoaded", function() {
  const elements = document.querySelectorAll("[data-action='toggle-navigation']")

  elements.forEach((element) => element.removeEventListener("click", toggleNavigation))
  elements.forEach((element) => element.addEventListener("click", toggleNavigation))
})

function toggleNavigation(event) {
  event.preventDefault()

  const target = document.querySelector("[data-target='navigation']")

  target.classList.toggle("active")
}

window.addEventListener('scroll', function() {
  const header = document.querySelector(".header")
  if(document.documentElement.scrollTop > 100) {
    header.classList.add('header--small')
  } else {
    header.classList.remove('header--small')
  }
})
