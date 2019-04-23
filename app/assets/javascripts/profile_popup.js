document.addEventListener("DOMContentLoaded", function() {
  const openClaimMobile = document.querySelector(".profile__claim-popup")
  openClaimMobile.addEventListener('click', function() {
    claimPopup("open")
  })

  const closeClaimMobile = document.querySelector(".profile__claim-popup-close")
  closeClaimMobile.addEventListener('click', function() {
    claimPopup("close")
  })
})

function claimPopup(target) {
  const claimPopupMobile = document.querySelector(".profile__claim-parent")
  if(target == "open") {
    claimPopupMobile.classList.add('active')
  } else {
    claimPopupMobile.classList.remove('active')
  }
}
