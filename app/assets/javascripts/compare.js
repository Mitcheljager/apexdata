document.addEventListener("turbolinks:load", function() {
  const elements = document.querySelectorAll("[data-action='compare']")

  elements.forEach((element) => element.removeEventListener("click", compareAgainstItem))
  elements.forEach((element) => element.addEventListener("click", compareAgainstItem))
})

function compareAgainstItem() {
  event.preventDefault()

  removeCompareAgainst()

  const compareItem = this.closest("[data-compare-item]")
  const compareTargets = compareItem.querySelectorAll("[data-compare-target]")

  compareItem.classList.add("item--compare-main")

  compareTargets.forEach((element) => {
    main = element.dataset.compareTarget
    mainValue = parseInt(element.innerHTML)

    const allTargets = document.querySelectorAll(`[data-compare-target="${ main }"]`)

    allTargets.forEach((target) => {
      if (target.closest("[data-compare-item]") == element.closest("[data-compare-item]")) return

      const targetValue = parseInt(target.innerHTML)

      const calculationElement = document.createElement("div")
      calculationElement.classList.add("compare__difference")

      if (targetValue > mainValue) {
        target.classList.add("compare-higher")

        const difference = targetValue - mainValue
        calculationElement.innerHTML = `+ ${ difference }`

        target.appendChild(calculationElement)
      } else if (targetValue < mainValue) {
        target.classList.add("compare-lower")

        const difference = mainValue - targetValue
        calculationElement.innerHTML = `- ${ difference }`

        target.appendChild(calculationElement)
      }
    })
  })

  showCompareAgainstItemElement(compareItem)
}

function showCompareAgainstItemElement(compareItem) {
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

function removeCompareAgainst() {
  const allTargets = document.querySelectorAll(`[data-compare-target]`)
  const compareAgainstElement = document.querySelector(".compare-float")
  const currentCompareMain = document.querySelector(".item--compare-main")
  const differenceElements = document.querySelectorAll(".compare__difference")

  if (currentCompareMain) currentCompareMain.classList.remove("item--compare-main")
  if (allTargets) allTargets.forEach((target) => target.classList.remove("compare-higher", "compare-lower"))
  if (compareAgainstElement) compareAgainstElement.remove()
  if (differenceElements) differenceElements.forEach((element) => element.remove())
}
