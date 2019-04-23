document.addEventListener("DOMContentLoaded", function() {
  const openClaimMobile = document.querySelector(".profile__claim-popup")
  if(openClaimMobile !== null) {
    openClaimMobile.addEventListener('click', function() {
      claimPopup("open")
    })
  }

  const closeClaimMobile = document.querySelector(".profile__claim-popup-close")
  if(closeClaimMobile !== null) {
    closeClaimMobile.addEventListener('click', function() {
      claimPopup("close")
    })
  }

  const openUpdatePopup = document.querySelectorAll(".profile-stats__update")
  if(openUpdatePopup !== null){
    openUpdatePopup.forEach(function (update) {
      update.addEventListener("click", function () {
        const parent = this.closest(".profile-stats__updates")
        const updatePopup = parent.querySelector(".profile__popup")
        updatePopup.classList.add("active")
      })
    })
  }

  const closeUpdatePopup = document.querySelectorAll(".profile-popup__close")
  if(closeUpdatePopup !== null){
    closeUpdatePopup.forEach(function (update) {
      update.addEventListener("click", function () {
        const parent = this.closest(".profile-stats__updates")
        const updatePopup = parent.querySelector(".profile__popup")
        updatePopup.classList.remove("active")
      })
    })
  }
})

function claimPopup(target) {
  const claimPopupMobile = document.querySelector(".profile__claim-parent")
  if(target == "open") {
    claimPopupMobile.classList.add('active')
  } else {
    claimPopupMobile.classList.remove('active')
  }
}
