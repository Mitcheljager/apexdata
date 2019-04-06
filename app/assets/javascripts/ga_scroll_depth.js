let scrolledPast25 = false
let scrolledPast50 = false
let scrolledPast75 = false

document.addEventListener("DOMContentLoaded", function() {
  document.removeEventListener("scroll", checkScrollDepth)
  document.addEventListener("scroll", checkScrollDepth)
})

function checkScrollDepth() {
  const scrollDistance = window.scrollY
  const documentHeight = document.body.clientHeight
  const windowHeight = window.innerHeight

  const scrollView = scrollDistance + windowHeight
  const scrollPercentage = (scrollView / documentHeight) * 100

  if (scrollPercentage > 25 && !scrolledPast25) {
    scrolledPast25 = true
    trackScrollDepthGA("25% Scroll reached")
  } else if (scrollPercentage > 50 && !scrolledPast50) {
    scrolledPast50 = true
    trackScrollDepthGA("50% Scroll reached")
  } else if (scrollPercentage > 75 && !scrolledPast75) {
    scrolledPast75 = true
    trackScrollDepthGA("75% Scroll reached")
  }
}

function trackScrollDepthGA(label) {
  if (typeof gtag !== "function") return

  gtag("event", "Scroll Depth", {
    "event_category": label,
    "event_label": window.location.pathname
  })
}
