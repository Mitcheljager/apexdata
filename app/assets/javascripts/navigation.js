document.addEventListener("DOMContentLoaded", function() {
  const mobileMenu = document.querySelector(".navigation")

  const mobileMenuOpen = document.querySelector(".navigation-open")
  mobileMenuOpen.addEventListener("click", function() {
    mobileMenu.classList.toggle("active")
    document.body.classList.toggle("menu")
  })

  const mobileMenuClose = document.querySelector(".navigation-close")
  mobileMenuClose.addEventListener("click", function() {
    mobileMenu.classList.toggle("active")
    document.body.classList.toggle("menu")
  })
})


function toggleNavigation(event) {
  event.preventDefault()
  const target = document.querySelector("[data-target='navigation']")
  target.classList.toggle("active")
}

const navigationToggle = ({ target }) => target.classList.toggle("active")
