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

  valueElement.innerHTML = data.data_value

  setTimeout(() => { valueElement.classList.remove("leaderboard__score-total--is-updated")}, 500)
}

function createLeaderboardItem(data) {
  console.log(data)
  const leaderboardElement = document.querySelector("[data-role='leaderboard']")
  const currentItemCount = document.querySelectorAll("[data-role='leaderboard-item']").length

  const leaderboardItem = document.createElement("div")

  const template = `
  <div class="leaderboard__item svg-badge-basic"
    data-role="leaderboard-item"
    data-leaderboard-item="${ data.profile_uid }">

    <div class="leaderboard__item-content">
      <div class="leaderboard__left">
        <div class="leaderboard__badge">
          <span class="leaderboard__position">${ currentItemCount + 1 }</span>

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
  </div>
  `

  leaderboardItem.innerHTML = template


  leaderboardElement.append(leaderboardItem)
}
