document.addEventListener("DOMContentLoaded", function() {
  const elements = document.querySelectorAll("[data-action='item-more-data']")

  elements.forEach((element) => element.removeEventListener("click", moreDetails))
  elements.forEach((element) => element.addEventListener("click", moreDetails))

  const all = document.querySelector("[data-action='more-data-all']")

  all.removeEventListener("click", moreDetailsAll)
  all.addEventListener("click", moreDetailsAll)
})

function moreDetails(event) {
  event.preventDefault()

  const parentElement = this.closest(".item")
  parentElement.classList.toggle("item--more-data")

  this.classList.toggle("button--primary")
  if (this.innerHTML == "More data") {
    this.innerHTML = "Less data"
  } else {
    this.innerHTML = "More data"
  }

  trackMoreDataGA(parentElement.querySelector("h3 a").innerHTML)
}

function moreDetailsAll(event) {
  event.preventDefault()

  this.classList.toggle("toggle--active")

  const items = document.querySelectorAll(".item")

  if (this.classList.contains("toggle--active")) {
    items.forEach((element) => {
      element.classList.add("item--more-data")

      const button = element.querySelector("[data-action='item-more-data']")
      button.classList.remove("button--primary")
      button.innerHTML = "Less data"
    })

    document.cookie = "alldata=expanded"
  } else {
    items.forEach((element) => {
      element.classList.remove("item--more-data")

      const button = element.querySelector("[data-action='item-more-data']")
      button.classList.add("button--primary")
      button.innerHTML = "More data"
    })

    document.cookie = "alldata=compact"
  }
}

function trackMoreDataGA(label) {
  if (typeof gtag !== "function") return

  gtag("event", "More Data", {
    "event_category" : label
  })
}
