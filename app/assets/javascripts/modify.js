document.addEventListener("DOMContentLoaded", function() {
  const elements = document.querySelectorAll("[data-action='set-modifier']")
  const removeElements = document.querySelectorAll("[data-action='remove-modifier']")

  elements.forEach((element) => element.addEventListener("click", setModifier))
  removeElements.forEach((element) => element.addEventListener("click", removeModifier))
  document.addEventListener("changeItem", removeAllModifiers)
})

function setModifier(event) {
  event.preventDefault()

  removeModifier(event, this.closest(".attachments-table__item"))

  const targets = JSON.parse(this.dataset.toModify)
  const currentItemElement = this.closest("[data-item-columns-main]").querySelector(".item-columns__item--is-active")
  const currentItemData = JSON.parse(currentItemElement.dataset.columnsData)

  Object.keys(targets).forEach((target) => {
    const targetElements = this.closest(".item-columns__detail").querySelectorAll(`[data-modify-target="${ target }"]`)
    const rarity = this.dataset.modifyRarity

    targetElements.forEach((targetElement) => {
      const dataTarget = targetElement.dataset.target

      console.log(targetElement)

      const targetValue = parseFloat(currentItemData[dataTarget])
      const attachmentValue = parseFloat(targets[target])

      if (typeof targetElement.dataset.modifyCssVariable !== "undefined") {
        modifyCSSVariable(targetElement, attachmentValue)
        return
      }

      console.log(targetElement)
      console.log(targetValue)

      const alreadyActiveModifier = targetElement.querySelector(".item__small-info-modify-value")
      if (alreadyActiveModifier) alreadyActiveModifier.remove()

      const percentageOf = targetValue / 100 * attachmentValue
      let newValue = Math.round(percentageOf * 100) / 100
      if (typeof targetElement.dataset.modifyRound !== "undefined") newValue = Math.round(newValue)

      const modifyElement = document.createElement("span")
      modifyElement.classList.add("modify-element")
      modifyElement.classList.add(`color-${ rarity }`)
      modifyElement.innerHTML = `${ Math.sign(newValue) == 1 ? "+" : "" }${ newValue }`

      if (targetElement.dataset.role == "bar-graph") {
        modifyBarGraph(percentageOf, targetElement, modifyElement, rarity)
        return
      }

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

function modifyBarGraph(percentageOf, barElement, modifyElement, rarity) {
  const lineElement = barElement.querySelector("[data-role='bar-graph-line']")
  const valueElement = barElement.querySelector("[data-role='bar-graph-value']")

  const maxValue = barElement.querySelector("[data-role='bar-graph-bar']").dataset.max

  const modifyBarElement = document.createElement("div")
  modifyBarElement.classList.add("bar-graph__modify")
  modifyBarElement.classList.add("modify-element")
  modifyBarElement.classList.add(`bg-${ rarity }`)

  lineElement.classList.add("modify-full-width-placeholder")
  lineElement.append(modifyBarElement)
  valueElement.prepend(modifyElement)
  setTimeout(() => { modifyBarElement.style.width = percentageOf + "%" })
}

function removeModifier(event, parentElement = undefined) {
  if (!parentElement) parentElement = this.closest(".attachments-table__item")
  const detailElement = parentElement.closest(".item-columns__detail")
  const attachmentItems = parentElement.querySelectorAll(".attachments-table__dropdown-item")
  const classes = parentElement.className.split(" ").filter(c => !c.startsWith("border-"))
  parentElement.className = classes.join(" ").trim()

  let dataTargets = []
  attachmentItems.forEach((dropdownItem) => {
    if (!dropdownItem.dataset.toModify) return

    const targets = JSON.parse(dropdownItem.dataset.toModify)
    Object.keys(targets).forEach((target) => dataTargets.push(target))
  })

  dataTargets.forEach((dataTarget) => {
    const targetElements = detailElement.querySelectorAll(`[data-modify-target=${ dataTarget }]`)

    targetElements.forEach((targetElement) => {
      if (typeof targetElement.dataset.modifyCssVariable !== "undefined") {
        resetCSSVariable(targetElement)
        return
      }

      const element = targetElement.querySelector(".modify-element")
      if (element) element.remove()

      const modifyBarPlaceholder = targetElement.querySelector(".modify-full-width-placeholder")
      if (modifyBarPlaceholder) modifyBarPlaceholder.classList.remove("modify-full-width-placeholder")
    })
  })
}

function removeAllModifiers() {
  const elements = document.querySelectorAll(".modify-element")
  elements.forEach(element => element.remove())

  const activeAttachmentItems = document.querySelectorAll(".attachments-table__item[class*='border-']")
  activeAttachmentItems.forEach(element => {
    const classes = element.className.split(" ").filter(c => !c.startsWith("border-"))
    element.className = classes.join(" ").trim()
  })

  const modifyBarPlaceholder = document.querySelector(".modify-full-width-placeholder")
  if (modifyBarPlaceholder) modifyBarPlaceholder.classList.remove("modify-full-width-placeholder")
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
