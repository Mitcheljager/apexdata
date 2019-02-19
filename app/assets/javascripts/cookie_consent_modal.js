document.addEventListener("turbolinks:load", function() {
  const element = document.querySelector("[data-action='open-cookie-consent-modal']")

  element.removeEventListener("click", showConsentModal)
  element.addEventListener("click", showConsentModal)
})

function showConsentModal(event) {
  event.preventDefault()
  window.__cmp("showConsentModal")
}
