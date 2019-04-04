document.addEventListener("DOMContentLoaded", function() {
  const elements = document.querySelectorAll("[data-action='set-modifier']")
  const removeElements = document.querySelectorAll("[data-action='remove-modifier']")

  elements.forEach((element) => element.addEventListener("click", setModifier))
  removeElements.forEach((element) => element.addEventListener("click", removeModifier))
})

function setModifier(event) {
  event.preventDefault()

  const targets = JSON.parse(this.dataset.toModify)
  const currentItemElement =

  Object.keys(targets).forEach((target) => {
    const targetElements = this.closest(".item-columns__detail").querySelectorAll(`[data-modify-target="${ target }"]`)
    const rarity = this.dataset.modifyRarity

    targetElements.forEach((targetElement) => {
      const targetValue = parseFloat(targetElement.innerHTML)
      let value = targets[target]
      value.replace("%", "")
      value = parseFloat(value)

      if (typeof targetElement.dataset.modifyCssVariable !== "undefined") {
        modifyCSSVariable(targetElement, value)
        return
      }

      const alreadyActiveModifier = targetElement.querySelector(".item__small-info-modify-value")
      if (alreadyActiveModifier) alreadyActiveModifier.remove()

      const percentageOf = targetValue / 100 * value
      let newValue = Math.round(percentageOf * 100) / 100
      if (typeof targetElement.dataset.modifyRound !== "undefined") newValue = Math.round(newValue)

      const modifyElement = document.createElement("span")
      modifyElement.classList.add("modify-element")
      modifyElement.classList.add(`color-${ rarity }`)
      modifyElement.innerHTML = `(${ Math.sign(newValue) == 1 ? "+" : "" }${newValue})`

      targetElement.prepend(modifyElement)
    })
  })

  changeItemIcon(this)
}

function changeItemIcon(self) {
  const parentElement = self.closest(".attachments-table__item")
  const parentImage = parentElement.querySelector("img")
  const itemImage = self.querySelector("img")
  const rarity = self.dataset.modifyRarity

  parentImage.src = itemImage.src

  const classes = parentElement.className.split(" ").filter(c => !c.startsWith("border-"));
  parentElement.className = classes.join(" ").trim()
  parentElement.classList.add(`border-${ rarity }`)
}

function removeModifier() {
  const item = this.closest(".item")
  const parentElement = this.closest(".attachments-table__item")
  const classes = parentElement.className.split(" ").filter(c => !c.startsWith("border-"))
  parentElement.className = classes.join(" ").trim()

  let dataTargets = []
  parentElement.querySelectorAll(".attachments-table__dropdown-item").forEach((dropdownItem) => {
    if (!dropdownItem.dataset.toModify) return

    const targets = JSON.parse(dropdownItem.dataset.toModify)

    Object.keys(targets).forEach((target) => dataTargets.push(target))
  })

  dataTargets.forEach((dataTarget) => {
    const targetElements = item.querySelectorAll(`[data-modify-target=${ dataTarget }]`)

    targetElements.forEach((targetElement) => {
      if (typeof targetElement.dataset.modifyCssVariable !== "undefined") {
        resetCSSVariable(targetElement)
        return
      }

      const element = targetElement.querySelector(".item__small-info-modify-value")
      if (element) element.remove()
    })
  })
}

function modifyCSSVariable(element, value) {
  value = 1 + (value / 100)

  element.style.setProperty("--modifier", value)
}

function resetCSSVariable(element) {
  element.style.setProperty("--modifier", 1)
}

function trackModifyGA(label) {
  if (typeof gtag !== "function") return

  gtag("event", "Modify", {
    "event_category" : label
  })
}
