document.addEventListener("turbolinks:load", function() {
  const elements = document.querySelectorAll("[data-action='compare']")

  elements.forEach((element) => element.removeEventListener("click", compareAgainstItem))
  elements.forEach((element) => element.addEventListener("click", compareAgainstItem))
})

function compareAgainstItem() {
  event.preventDefault()

  const compareItem = this.closest("[data-compare-item]")
  const compareTargets = compareItem.querySelectorAll("[data-compare-target]")

  compareTargets.forEach((element) => {
    main = element.dataset.compareTarget
    mainValue = parseInt(element.innerHTML)

    const allTargets = document.querySelectorAll(`[data-compare-target="${ main }"]`)

    allTargets.forEach((target) => {
      target.classList.remove("compare-higher", "compare-lower")

      if (target.closest("[data-compare-item]") == element.closest("[data-compare-item]")) return

      const targetValue = parseInt(target.innerHTML)

      if (targetValue > mainValue) {
        target.classList.add("compare-higher")
      } else if (targetValue < mainValue) {
        target.classList.add("compare-lower")
      }
    })
  })

  showCompareAgainstItemElement(compareItem)
}

function showCompareAgainstItemElement(compareItem) {
  if (document.querySelector(".compare-float")) {
    document.querySelector(".compare-float span").innerHTML = `Comparing against <strong>${ compareItem.dataset.compareItem }</strong>`
  } else {
    const compareAgainstElement = document.createElement("div")
    compareAgainstElement.classList.add("compare-float")
    compareAgainstElement.innerHTML = `<span>Comparing against <strong>${ compareItem.dataset.compareItem }</strong><span>`

    const compareAgainstElementClose = document.createElement("div")
    compareAgainstElementClose.classList.add("compare-float__close")
    compareAgainstElementClose.innerHTML = "x"
    compareAgainstElementClose.addEventListener("click", removeCompareAgainst)

    compareAgainstElement.appendChild(compareAgainstElementClose)

    document.body.appendChild(compareAgainstElement)
  }
}

function removeCompareAgainst() {
  const allTargets = document.querySelectorAll(`[data-compare-target]`)
  const compareAgainstElement = document.querySelector(".compare-float")

  allTargets.forEach((target) => target.classList.remove("compare-higher", "compare-lower"))
  compareAgainstElement.remove()
}
