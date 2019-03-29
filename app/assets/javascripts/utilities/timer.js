function startTimer(duration, startAt, display) {
  var curTime = Math.floor((new Date()).getTime() / 1000)
  var diff = curTime - startAt;
  var newDuration = duration > diff ? duration - diff : 0;
  var timer = newDuration, minutes, seconds;

  setInterval(function () {
    minutes = parseInt(timer / 60, 10)
    seconds = parseInt(timer % 60, 10);

    minutes = minutes < 10 ? `0${minutes}` : minutes;
    seconds = seconds < 10 ? `0${seconds}` : seconds;

    display.textContent = `${minutes}:${seconds}`;

    if (--timer < 0) {
      timer = newDuration;
    }
  }, 1000);
}

window.onload = function () {
  var timer = document.querySelector('#timer');
  if (timer) {
    var duration = timer.dataset.duration;
    var startAt = timer.dataset.time;
  }

  if (timer && duration && startAt) {
    startTimer(duration, startAt, timer);
  }
};
