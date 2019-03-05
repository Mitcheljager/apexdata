document.addEventListener("DOMContentLoaded", function() {
  const elements = document.querySelectorAll("[data-role='strawpoll-tierlist']")
  elements.forEach(element => getList(element))
})

function getList(element) {
  const url = element.dataset.url

  fetch(url).then((response) => {
    return response.json()
  }).then((json) => {
    makeList(element, json)
  })
}

function makeList(parentElement, data) {
  let items = []

  data.options.forEach((option, index) => {
    items[option] = data.votes[index]
  })

  const keys = Object.keys(items)
  keys.sort((a, b) => items[b] - items[a])

  parentElement.innerHTML = ""
  keys.forEach(key => parentElement.append(itemTemplate(key)))
}

function itemTemplate(name) {
  const element = document.createElement("div")
  element.classList.add("tierlist__item")
  element.innerHTML = name

  return element
}
