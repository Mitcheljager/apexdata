document.addEventListener("DOMContentLoaded", function() {
  const element = document.querySelector("[data-action='toggle-notifications']")

  element.addEventListener("click", toggleNotifications)
})

function toggleNotifications() {
  const bubble = document.querySelector(".notifications__bubble")
  if (bubble) bubble.remove()
  
  document.querySelector(".notifications__trigger").classList.toggle("notifications__trigger--is-active")
  document.querySelector(".notifications__content").classList.toggle("notifications__content--is-active")
}
