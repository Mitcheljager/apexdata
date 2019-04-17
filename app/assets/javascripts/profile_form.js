document.addEventListener("DOMContentLoaded", function() {
  const profileForm = document.querySelector(".player-form")

  const platforms = document.querySelectorAll(".platform__icon")
  platforms.forEach(function (platform) {
    platform.addEventListener("click", function () {
      const parent = this.closest("form")
      const currentActive = parent.querySelector(".platform__icon.active")

      currentActive.classList.remove("active")
      this.classList.add("active")
    })
  })

  profileForm.addEventListener("submit", function (event) {
    event.preventDefault()

    const playerName = this.querySelector("#playerName").value
    const playerPlatform = this.querySelector(".platform__icon.active").dataset.platform
    
    toProfile(playerName, playerPlatform)
  })
})

const toProfile = (user, platform) => {
  if(user != null && user != "" && platform != null && platform != "") {
    window.location.href = `/profile/${platform}/${user}`
  }
}
