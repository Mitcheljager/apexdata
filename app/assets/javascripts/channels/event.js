//= require cable
//= require_self

document.addEventListener("DOMContentLoaded", function() {
  const leaderboardElement = document.querySelector("[data-role='leaderboard']")

  if (!leaderboardElement) return

  App.cable.subscriptions.create({ channel: "EventsChannel", event_id: leaderboardElement.dataset.eventId }, {
    received: function(data) {
      if (data.is_new) {
        createLeaderboardItem(data)
      } {
        updateLeaderboardItem(data)
      }
    }
  })
})

function updateLeaderboardItem(data) {
  const element = document.querySelector(`[data-leaderboard-item="${ data.profile_uid }"]`)

  if (!element) return

  const valueElement = element.querySelector(`[data-role="leaderboard-total-value"]`)
  valueElement.classList.add("leaderboard__score-total--is-updated")

  const currentValue = parseInt(valueElement.innerHTML)
  const changeValue = data.data_value - currentValue

  const changeElement = document.createElement("div")
  changeElement.classList.add("leaderboard__score-total-change")
  changeElement.innerHTML = "+" + changeValue

  element.dataset.leaderboardValue = data.data_value
  valueElement.innerHTML = data.data_value
  valueElement.append(changeElement)

  sortLeaderboard()

  setTimeout(() => { valueElement.classList.remove("leaderboard__score-total--is-updated") }, 500)
  setTimeout(() => { changeElement.remove() }, 2000)
}

function sortLeaderboard() {
  const leaderboardElement = document.querySelector("[data-role='leaderboard']")
  const elements = document.querySelectorAll(`[data-leaderboard-item]`)
  const elementsArray = Array.from(elements)

  elementsArray.sort((a, b) => {
    if (parseInt(a.dataset.leaderboardValue) > parseInt(b.dataset.leaderboardValue)) return -1
    if (parseInt(a.dataset.leaderboardValue) < parseInt(b.dataset.leaderboardValue)) return 1
  })

  console.log(elementsArray)

  elementsArray.forEach(element => leaderboardElement.appendChild(element))
}

function createLeaderboardItem(data) {
  const leaderboardElement = document.querySelector("[data-role='leaderboard']")

  const leaderboardItem = document.createElement("div")
  leaderboardItem.setAttribute("data-role", "leaderboard-item")
  leaderboardItem.setAttribute("data-leaderboard-item", data.profile_uid)
  leaderboardItem.setAttribute("data-leaderboard-value", 0)
  leaderboardItem.classList.add("leaderboard__item", "svg-badge-basic")

  const template = `
    <div class="leaderboard__item-content">
      <div class="leaderboard__left">
        <div class="leaderboard__badge">
          <span class="leaderboard__position"></span>

          ${ data.image }
        </div>


        <span class="leaderboard__name">${ data.username }</span>
      </div>
      <div class="leaderboard__right">
        <div class="leaderboard__score">
          <span class="leaderboard__score-name">${ data.data_name }</span>
          <span class="leaderboard__score-total" data-role="leaderboard-total-value">${ data.data_value }</span>
        </div>

        <a class="leaderboard__action" href="${ data.path }">View profile</a>
      </div>
    </div>
  `

  leaderboardItem.innerHTML = template

  leaderboardElement.append(leaderboardItem)
}
