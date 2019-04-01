let compareData = ""
let currentData = ""

document.addEventListener("DOMContentLoaded", function() {
  const elements = document.querySelectorAll("[data-action='compare']")

  elements.forEach((element) => element.addEventListener("click", setCompareData))
  document.addEventListener("changeItem", initiateCompare)
})

function initiateCompare(event) {
  if (compareData == "") return

  setCurrentData(event.detail.name)
  compareStaticValues(event.detail.detailElement)
  compareBarGraph(event.detail.detailElement)

  trackCompareGA(compareData["name"])
}

function setCompareData(event) {
  event.preventDefault()

  resetCompareData()

  const detailsElement = this.closest("[data-role='item-columns-details']")
  const compareName = detailsElement.querySelector("[data-target='name']").innerHTML.toLowerCase().replace(" ", "_")
  const compareElement = document.querySelector(`[data-compare-source="${ compareName }"]`)
  compareData = JSON.parse(compareElement.dataset.columnsData)

  compareElement.classList.add("item-columns__item--is-compare")
}

function resetCompareData() {
  if (compareData != "") {
    const currentCompareElement = document.querySelector(`[data-compare-source="${ compareData.name.toLowerCase().replace(" ", "_") }"]`)
    if (currentCompareElement) currentCompareElement.classList.remove("item-columns__item--is-compare")
  }

  const compareElements = document.querySelectorAll(".compare-element")
  compareElements.forEach(element => element.remove())

  compareData = ""
}

function setCurrentData(itemName) {
  const currentItem = document.querySelector(`[data-compare-source="${ itemName }"]`)
  currentData = JSON.parse(currentItem.dataset.columnsData)
}

function compareStaticValues(detailElement) {
  const elements = detailElement.querySelectorAll("[data-compare-static]")

  elements.forEach(element => {
    const target = element.dataset.compareStatic
    const compareDifference = getDifference(target)
    if (compareDifference == 0) return

    let isPositive = true
    if (Math.sign(compareDifference) == -1) isPositive = false

    const resultElement = document.createElement("div")
    resultElement.classList.add("compare-element")
    if (isPositive) {
      resultElement.innerHTML = `(+${ compareDifference })`
      resultElement.classList.add("compare-higher")
    } else {
      resultElement.classList.add("compare-lower")
      resultElement.innerHTML = `(${ compareDifference })`
    }

    element.prepend(resultElement)
  })
}

function compareBarGraph(detailElement) {
  const elements = detailElement.querySelectorAll("[data-compare-bar]")

  elements.forEach(element => {
    const target = element.dataset.compareBar
    const compareDifference = getDifference(target)

    const barElement = element.closest("[data-role='bar-graph']")
    const lineElement = barElement.querySelector("[data-role='bar-graph-line']")
    lineElement.innerHTML = ""

    if (compareDifference == 0) return

    let isPositive = true
    if (Math.sign(compareDifference) == -1) isPositive = false

    const maxValue = barElement.querySelector("[data-role='bar-graph-bar']").dataset.max
    const valuePercentage = Math.abs(Math.round((compareDifference / maxValue) * 100))

    const resultElement = document.createElement("div")
    resultElement.classList.add("compare-element")

    const compareBarElement = document.createElement("div")
    compareBarElement.classList.add("bar-graph__compare")
    compareBarElement.classList.add("compare-element")

    if (isPositive) {
      resultElement.innerHTML = `(+${ compareDifference })`
      resultElement.classList.add("compare-higher")
      compareBarElement.classList.add("bar-graph__compare--positive")
    } else {
      resultElement.classList.add("compare-lower")
      resultElement.innerHTML = `(${ compareDifference })`
      compareBarElement.classList.add("bar-graph__compare--negative")

      const lineElementWidth = parseInt(lineElement.style.width)
      lineElement.style.width = lineElementWidth + valuePercentage + "%"
    }

    element.prepend(resultElement)
    lineElement.append(compareBarElement)
    setTimeout(() => { compareBarElement.style.width = valuePercentage + "%" })
  })
}

function getDifference(target) {
  const currentValue = currentData[target]
  const compareValue = compareData[target]

  let compareDifference = currentValue - compareValue
  compareDifference = Math.round(compareDifference * 100) / 100

  return compareDifference
}

function trackCompareGA(label) {
  if (typeof gtag !== "function") return

  gtag("event", "Compare", {
    "event_category" : label
  })
}
