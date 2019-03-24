document.addEventListener("DOMContentLoaded", function() {
  const detailElements = document.querySelectorAll("[data-action='item-columns-change-details']")
  detailElements.forEach(element => element.addEventListener("click", changeDetails))

  const categoryElements = document.querySelectorAll("[data-action='item-columns-change-category']")
  categoryElements.forEach(element => element.addEventListener("click", changeCategory))
})

function changeCategory(event) {
  event.preventDefault()

  const blocks = document.querySelectorAll("[item-columns-target]")
  blocks.forEach(block => {
    block.style.display = "none"
    block.querySelector(".item-columns__detail").style.display = "none"
  })

  const target = this.dataset.target
  const targetElement = document.querySelector(`[item-columns-target='${ target }']`)
  targetElement.style.display = "flex"
}

function changeDetails(event) {
  event.preventDefault()

  const data = JSON.parse(this.dataset.columnsData)
  const targetParent = this.closest("[item-columns-target]").querySelector("[data-role='item-columns-details']")

  if (targetParent.style.display != "block") targetParent.style.display = "block"

  changeBarGraphs(targetParent, data)
  changeCircleGraphs(targetParent, data)
  changeStaticValues(targetParent, data)
  changeIcon(targetParent, this.dataset.iconSource)
}

function changeIcon(parent, image) {
  const iconElement = parent.querySelector("[data-role='item-columns-detail-icon']")
  iconElement.src = image
}

function changeStaticValues(parent, data) {
  const elements = parent.querySelectorAll("[data-role='static-value']")

  elements.forEach(element => {
    const target = element.dataset.target
    const value = data[target]

    element.innerHTML = value
  })
}

function changeBarGraphs(parent, data) {
  const graphs = parent.querySelectorAll("[data-role='bar-graph']")

  graphs.forEach(graph => {
    const dataTarget = graph.dataset.target
    const barElement = graph.querySelector("[data-role='bar-graph-bar']")
    const valueElement = graph.querySelector("[data-role='bar-graph-value']")

    valueElement.innerHTML = data[dataTarget]

    setBarWidth(barElement, data[dataTarget])
  })
}

function setBarWidth(barElement, value) {
  const lineElement = barElement.querySelector("[data-role='bar-graph-line']")
  const maxValue = barElement.dataset.max
  const valuePercentage = (value / maxValue) * 100

  lineElement.style.width = valuePercentage + "%"
}

function changeCircleGraphs(parent, data) {
  const graphs = parent.querySelectorAll("[data-role='circle-graph']")

  graphs.forEach(graph => {
    const dataTarget = graph.dataset.target
    const barElement = graph.querySelector("[data-role='circle-graph-bar']")
    const valueElement = graph.querySelector("[data-role='circle-graph-value']")

    valueElement.innerHTML = data[dataTarget]

    setCircleValue(barElement, data[dataTarget])
  })
}

function setCircleValue(barElement, value) {
  const maxValue = barElement.dataset.max
  const valuePercentage = (value / maxValue) * 100
  const currentValue = parseFloat(barElement.style.getPropertyValue("--value"))

  if (currentValue) {
    const difference = valuePercentage - currentValue

    if (Math.round(difference) != 0) {
      const transitionDuration = 200
      const fps = 20
      const interval = transitionDuration / fps
      const step = difference / interval
      let currentStep = currentValue

      let iteration = 0
      const intervalTimer = setInterval(() => {
        iteration++
        currentStep = currentStep + step

        barElement.style.setProperty("--value", currentStep)

        if (iteration == interval) {
          barElement.style.setProperty("--value", valuePercentage)
          clearInterval(intervalTimer)
        }
      }, interval)
    }
  } else {
    barElement.style.setProperty("--value", valuePercentage)
  }
}
