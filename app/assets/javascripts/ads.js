function hideBlockedBanners() {
  const elements = document.querySelectorAll(".ad-container")

  elements.forEach(element => element.style.display = "none")
}
