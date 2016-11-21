// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require turbolinks
//= require_tree .

$(document).on('turbolinks:load', function() {
  $("body").on("hidden.bs.modal", ".modal", function () {
    $(this).removeData("bs.modal");
  });

  $("#div-list-word").on("click", ".word-item-flip", function () {
    $(this).siblings(".word-item-panel").slideToggle("slow");
  });

  $("#div-show-category").on("click", ".remove-answer-row", function () {
    var count = $(this).parent().siblings(".answer-row:visible").length + 1;
    if(count <= 2) {
      alert("Each word must have at least 2 answers");
    } else {
      $(this).prev("input[type=hidden]").val("1");
      $(this).closest(".answer-row").hide();
    }
  }).on("click", ".check-correct", function () {
    $(this).parent().siblings(".answer-row:visible").
      children(".check-correct").prop("checked", false);
  }).on("click", ".btn-add-answer", function (event) {
    event.preventDefault();
    time = new Date().getTime();
    regexp = new RegExp($(this).data("id"), "g");
    $(this).before($(this).data("fields").replace(regexp,time));
  });

  if ($("#duration_lesson").length) {
    initCountdown();
    $counter = setInterval(countdown, 1000);
  }
});

function initCountdown() {
  $duration = parseInt($("#duration_lesson").attr("value"));
  $minutes = Math.floor($duration/60);
  $seconds = $duration - $minutes*60;
}

function countdown() {
  $seconds--;
  if ($seconds < 0) {
    if ($minutes <= 0) {
      clearInterval($counter);
      $("form").submit();
    }
    $seconds = 59;
    $minutes--;
  }
  $("#lesson-countdown").html($minutes + " : " + $seconds);
}
