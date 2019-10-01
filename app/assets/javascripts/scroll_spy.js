document.addEventListener("DOMContentLoaded", function() {
  const element = document.querySelector("[data-role='scroll-spy']")
  if (element) {
    window.addEventListener("scroll", checkScrollSpy)
    window.addEventListener("resize", repositionScrollSpyNav)
  }

  const elements = document.querySelectorAll("[data-role='scroll-spy'] .scroll-spy__item")
  elements.forEach(element => element.addEventListener("click", goToScrollSpyItem))

  window.dispatchEvent(new Event("scroll"))
})

function checkScrollSpy(event) {
  event.preventDefault()

  let activeItem = 0
  const scrollPosition = document.documentElement.scrollTop

  const items = document.querySelectorAll("[data-scroll-spy]")

  items.forEach(item => {
    const itemPosition = item.offsetTop

    console.log(itemPosition)

    if (scrollPosition > itemPosition - 100) {
      activeItem++
    }
  })

  moveScrollSpyNav()
  setScrollSpyItem(activeItem)
}

function setScrollSpyItem(activeItem) {
  if (activeItem == 0) activeItem = 1
  const items = document.querySelectorAll("[data-role='scroll-spy'] .scroll-spy__item")
  const currentItem = document.querySelector(".scroll-spy__item--is-active")

  if (currentItem == items[activeItem - 1]) return

  if (currentItem) currentItem.classList.remove("scroll-spy__item--is-active")
  items[activeItem - 1].classList.add("scroll-spy__item--is-active")
}

function goToScrollSpyItem(event) {
  event.preventDefault()

  const url = this.href.substring(this.href.indexOf("#")+1)
  const itemPosition = document.querySelector(`#${ url }`).offsetTop

  window.scrollTo(0, itemPosition - 99)
}

function moveScrollSpyNav() {
  const scrollPosition = document.documentElement.scrollTop
  const element = document.querySelector("[data-role='scroll-spy']")
  const elementParent = element.closest(".relative")

  const elementPositionTop = elementParent.offsetTop
  const elementPositionLeft = elementParent.getBoundingClientRect().left

  if (scrollPosition > elementPositionTop - 100) {
    if (element.classList.contains("scroll-spy--is-fixed")) return
    element.classList.add("scroll-spy--is-fixed")
    element.style.top = "99px"
    element.style.left = elementPositionLeft - 30 + "px"
  } else {
    element.classList.remove("scroll-spy--is-fixed")
    element.removeAttribute("style")
  }
}

function repositionScrollSpyNav() {
  const element = document.querySelector("[data-role='scroll-spy']")
  if (!element.classList.contains("scroll-spy--is-fixed")) return

  const elementParent = element.closest(".relative")
  const elementPositionLeft = elementParent.getBoundingClientRect().left
  element.style.left = elementPositionLeft - 30 + "px"
}
