document.addEventListener("DOMContentLoaded", function() {
  const profileForms = document.querySelectorAll(".player-form")

  const platforms = document.querySelectorAll(".platform__icon")

  platforms.forEach(function (platform) {
    platform.addEventListener("click", function () {
      const parent = this.closest("form")
      const currentActive = parent.querySelector(".platform__icon.active")

      currentActive.classList.remove("active")
      this.classList.add("active")
    })
  })

  profileForms.forEach(profileForm => {
    profileForm.addEventListener("submit", function (event) {
      event.preventDefault()

      const playerName = this.querySelector("#playerName").value
      const playerPlatform = this.querySelector(".platform__icon.active").dataset.platform

      toProfile(playerName, playerPlatform)
    })
  })
})

const toProfile = (user, platform) => {
  if(user != null && user != "" && platform != null && platform != "") {
    trackProfileSearch(window.location.href)
    window.location.href = `/profile/${platform}/${user}`
  }
}

function trackProfileSearch(label) {
  if (typeof gtag !== "function") return

  gtag("event", "Profile Search", {
    "event_category" : label
  })
}
