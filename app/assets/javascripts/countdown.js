document.addEventListener("DOMContentLoaded", function() {
  const getEventTimeWrapper = document.querySelector(".event__time-wrapper");
  if(getEventTimeWrapper != null) {
    let getCurrentTime = getEventTimeWrapper.getAttribute("data-current-time");
        getCurrentTime = new Date(getCurrentTime);
    let getEventStart = getEventTimeWrapper.getAttribute("data-start-time");
    let getEventEnd = getEventTimeWrapper.getAttribute("data-end-time");

    if (getEventStart == null) {
      getEventEnd = new Date(getEventEnd);
      if(getCurrentTime < getEventEnd) {
        var difference = getEventEnd.getTime() - getCurrentTime.getTime();
        eventTimeLoad(difference);
        let runCounter = setInterval(function() {
          updateEventTime("eventEnd", runCounter);
        }, 1000);
      }
    } else {
      getEventStart = new Date(getEventStart);
      if(getCurrentTime < getEventStart) {
        var difference = getEventStart.getTime() - getCurrentTime.getTime();
        eventTimeLoad(difference);
        let runCounter = setInterval(function() {
          updateEventTime("eventStart", runCounter);
        }, 1000);
      }
    }
  }
});

function eventTimeLoad(difference) {
  let seconds = Math.floor(difference / 1000);
  let minutes = Math.floor(seconds / 60);
  let hours = Math.floor(minutes / 60);
  let days = Math.floor(hours / 24);

  hours %= 24;
  minutes %= 60;
  seconds %= 60;

  const getEventSec = document.querySelector(".event__sec");
  getEventSec.innerHTML = minTwoDigits(seconds);

  const getEventMin = document.querySelector(".event__min");
  getEventMin.innerHTML = minTwoDigits(minutes);

  const getEventHour = document.querySelector(".event__hour");
  getEventHour.innerHTML = minTwoDigits(hours);

  const getEventDay = document.querySelector(".event__day");
  getEventDay.innerHTML = minTwoDigits(days);
}

function updateEventTime(eventCat, runCounter) {
  //Sec;
  let getEventSec = document.querySelector(".event__sec").innerHTML;
  getEventSec = parseInt(getEventSec) - 1;
  if(getEventSec < 0) {
    //Sec
    getEventSec = 59;
    document.querySelector(".event__sec").innerHTML = minTwoDigits(getEventSec);

    //min;
    let getEventMin = document.querySelector(".event__min").innerHTML;
    getEventMin = parseInt(getEventMin) - 1;
    if(getEventMin < 0) {
      getEventMin = 59;
      document.querySelector(".event__min").innerHTML = minTwoDigits(getEventMin);

      //hour;
      let getEventHour = document.querySelector(".event__hour").innerHTML;
      getEventHour = parseInt(getEventHour) - 1;
      if(getEventHour < 0) {
        getEventHour = 59;
        document.querySelector(".event__hour").innerHTML = minTwoDigits(getEventHour);

        //days;
        let getEventDay = document.querySelector(".event__day").innerHTML;
        getEventDay = parseInt(getEventDay) - 1;
        if(getEventDay < 0) {
          clearInterval(runCounter);
          location.reload();
        } else {
          document.querySelector(".event__day").innerHTML = minTwoDigits(getEventDay);
        }

      } else {
        document.querySelector(".event__hour").innerHTML = minTwoDigits(getEventHour);
      }

    } else {
      document.querySelector(".event__min").innerHTML = minTwoDigits(getEventMin);
    }

  } else {
    document.querySelector(".event__sec").innerHTML = minTwoDigits(getEventSec);
  }
}

function minTwoDigits(n) {
  return (n < 10 ? '0' : '') + n;
}
