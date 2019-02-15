document.addEventListener("turbolinks:load", function() {
  const elements = document.querySelectorAll("[data-action='toggle-dropdown']")

  elements.forEach((element) => element.removeEventListener("click", toggleDropdown))
  elements.forEach((element) => element.addEventListener("click", toggleDropdown))
})

function toggleDropdown(event) {
  event.preventDefault()

  const target = this.querySelector("[data-dropdown]")

  const activeDropdown = document.querySelector("[data-dropdown].active")
  if (activeDropdown && activeDropdown != target) activeDropdown.classList.remove("active")

  target.classList.toggle("active")

  const activeDropdownTrigger = document.querySelector(".attachments-table__item--active")
  if (activeDropdownTrigger && activeDropdownTrigger != this) activeDropdownTrigger.classList.remove("attachments-table__item--active")
  this.classList.toggle("attachments-table__item--active")
}
