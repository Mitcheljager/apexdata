let compareData = ""
let currentData = ""

document.addEventListener("DOMContentLoaded", function() {
  const elements = document.querySelectorAll("[data-action='compare']")

  elements.forEach((element) => element.addEventListener("click", setCompareData))
  document.addEventListener("changeItem", initiateCompare)
  document.addEventListener("changeCategory", resetCompareData)
})

function initiateCompare(event) {
  if (compareData == "") return

  setCurrentData(event.detail.name)
  compareStaticValues(event.detail.detailElement)
  compareBarGraph(event.detail.detailElement)
  compareCircleGraph(event.detail.detailElement)
  setCompareButton(event.detail.detailElement)

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

  const compareActionsElement = detailsElement.querySelector("[data-role='compare-actions']")

  const compareActionsTextElement = document.createElement("div")
  compareActionsTextElement.classList.add("compare-element")
  compareActionsTextElement.innerHTML = `Currently comparing: <strong>${ compareData.name }</strong>`

  const compareActionsCancelElement = document.createElement("a")
  compareActionsCancelElement.innerHTML = `Cancel`
  compareActionsCancelElement.addEventListener("click", resetCompareData)

  compareActionsTextElement.append(compareActionsCancelElement)
  compareActionsElement.append(compareActionsTextElement)

  setCompareButton(detailsElement, true)

  if (document.body.clientWidth >= 640) return
  document.dispatchEvent(new CustomEvent("setCompare", {
    detail: {
      element: detailsElement.closest("[data-item-columns-main]")
    }
  }))
}

function resetCompareData() {
  if (compareData != "") {
    const currentCompareElement = document.querySelector(`[data-compare-source="${ compareData.name.toLowerCase().replace(" ", "_") }"]`)
    if (currentCompareElement) currentCompareElement.classList.remove("item-columns__item--is-compare")
  }

  const compareElements = document.querySelectorAll(".compare-element")
  compareElements.forEach(element => element.remove())

  const circleGraphElements = document.querySelectorAll("[data-role='circle-graph-bar']")
  if (circleGraphElements.length) circleGraphElements.forEach(element => element.style.background = "")

  const disabledButtons = document.querySelectorAll(".item-columns__compare-actions .button[disabled]")
  disabledButtons.forEach(element => element.removeAttribute("disabled"))

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

function compareCircleGraph(detailElement) {
  const elements = detailElement.querySelectorAll("[data-compare-circle]")

  elements.forEach(element => {
    const target = element.dataset.compareCircle
    const compareDifference = getDifference(target)

    const graphElement = element.closest("[data-role='circle-graph']")
    const barElement = graphElement.querySelector("[data-role='circle-graph-bar']")
    barElement.style.background = null

    if (compareDifference == 0) {
      barElement.style.setProperty("--compare-value", null)
      return
    }

    let isPositive = true
    if (Math.sign(compareDifference) == -1) isPositive = false

    const maxValue = barElement.dataset.max
    const valuePercentage = Math.abs(Math.round((currentData[target] / maxValue) * 100))
    const compareValuePercentage = Math.abs(Math.round((compareData[target] / maxValue) * 100))

    const resultElement = document.createElement("div")
    resultElement.classList.add("compare-element")

    if (isPositive) {
      resultElement.innerHTML = `(+${ compareDifference })`
      resultElement.classList.add("compare-higher")

      barElement.style.backgroundImage = `conic-gradient(var(--graph-color) ${ compareValuePercentage }%,
                                          var(--green) ${ compareValuePercentage }%,
                                          var(--green) var(--compare-value),
                                          var(--graph-bg) 0%)`
    } else {
      resultElement.innerHTML = `(${ compareDifference })`
      resultElement.classList.add("compare-lower")

      barElement.style.backgroundImage = `conic-gradient(var(--graph-color) var(--compare-value),
                                          var(--red) var(--compare-value),
                                          var(--red) ${ compareValuePercentage }%,
                                          var(--graph-bg) 0%)`
    }

    intervalCircleGraphCompare(compareValuePercentage, valuePercentage - compareValuePercentage, valuePercentage, barElement)
    element.append(resultElement)
  })
}

function getDifference(target) {
  const currentValue = currentData[target]
  const compareValue = compareData[target]

  let compareDifference = currentValue - compareValue
  compareDifference = Math.round(compareDifference * 100) / 100

  return compareDifference
}

function intervalCircleGraphCompare(value, starterStep, endValue, element) {
  const transitionDuration = 200
  const fps = 20
  const interval = transitionDuration / fps
  let step = starterStep / interval
  let currentStep = value

  const currentVar = parseInt(element.style.getPropertyValue("--compare-value"))
  if (currentVar) {
    currentStep = currentVar
    step = (endValue - currentVar) / interval
  } else {
    element.style.setProperty("--compare-value", value + "%")
  }

  let iteration = 0
  const intervalTimer = setInterval(() => {
    iteration++
    currentStep = currentStep + step

    element.style.setProperty("--compare-value", currentStep + "%")

    if (iteration == interval) {
      element.style.setProperty("--compare-value", endValue + "%")
      clearInterval(intervalTimer)
    }
  }, interval)
}

function setCompareButton(parentElement, toSet = undefined) {
  const button = parentElement.querySelector(".item-columns__compare-actions .button")
  if (toSet) {
    button.setAttribute("disabled", toSet)
    return
  }

  if (compareData.name == currentData.name) {
    button.setAttribute("disabled", true)
  } else {
    button.removeAttribute("disabled")
  }
}

function trackCompareGA(label) {
  if (typeof gtag !== "function") return

  gtag("event", "Compare", {
    "event_category" : label
  })
}
