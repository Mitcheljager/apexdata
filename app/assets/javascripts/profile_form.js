document.addEventListener("DOMContentLoaded", function() {
  bindPlatforms()
  bindForms()
})

const toProfile = (user, platform) => {
  if(user != null && user != "" && platform != null && platform != "") {
    trackProfileSearch(window.location.pathname)
    window.location.href = `/profile/${platform}/${user}`
  }
}

function bindPlatforms() {
  const platforms = document.querySelectorAll(".platform__icon")

  platforms.forEach(platform => platform.removeEventListener("click", setPlatform))
  platforms.forEach(platform => platform.addEventListener("click", setPlatform))
}

function bindForms() {
  const profileForms = document.querySelectorAll(".player-form")

  profileForms.forEach(profileForm => profileForm.removeEventListener("submit", setForm))
  profileForms.forEach(profileForm => profileForm.addEventListener("submit", setForm))
}

function setForm(event) {
  event.preventDefault()

  const playerName = this.querySelector("#playerName").value
  const playerPlatform = this.querySelector(".platform__icon.active").dataset.platform

  toProfile(playerName, playerPlatform)
}

function setPlatform(event) {
  event.preventDefault()

  const parent = this.closest("form")
  const currentActive = parent.querySelector(".platform__icon.active")

  currentActive.classList.remove("active")
  this.classList.add("active")
}

function trackProfileSearch(label) {
  if (typeof gtag !== "function") return

  gtag("event", "Profile Search", {
    "event_category" : label
  })
}
