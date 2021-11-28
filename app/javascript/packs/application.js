// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs";
import Turbolinks from "turbolinks";
import * as ActiveStorage from "@rails/activestorage";
import "channels";
import "bootstrap-icons/font/bootstrap-icons.css";
import "@fortawesome/fontawesome-free/js/all";
import "bootstrap";
global.$ = require("jquery");
require("jquery-ui");
import "chartkick/chart.js";
import "chartkick/highcharts"
Rails.start();
Turbolinks.start();
ActiveStorage.start();

$(document).on("turbolinks:load", function () {

  $('#draggable-scroll').draggable({
    scroll: true,
    scrollSensitivity: 40,
    scrollSpeed: 40
  });

  // draggable functionality
  $("#draggable").draggable();

  // form outlines
  document.querySelectorAll(".form-outline").forEach((formOutline) => {
    new mdb.Input(formOutline).init();
  });

  // create each chart for a coin
  document.querySelectorAll(".chart").forEach((charts) =>{
    const coin_id = $(charts).attr("id");
    create_chart("avg-chart", "/chart_data/avg?id="+coin_id)
    create_chart("ask-chart", "/chart_data/ask?id="+coin_id)
    create_chart("bid-chart", "/chart_data/bid?id="+coin_id)
  })

  // create average price charts for all coins
  document.querySelectorAll(".index_charts").forEach((avgChart) =>{
    const coin_ids = $(avgChart).children();
    console.log(coin_ids)
    coin_ids.each(
      function (child) {
        if (child % 2 == 1){
          const coin_id = $(coin_ids[child]).attr("id");
          const url = "/chart_data/avg?id="+coin_id;
          create_chart(coin_id, url)
        }
        
      }
    )
    
  })
});

function create_chart(id, url){
  return new Chartkick.LineChart(id, url,{
            min: null,
            ytitle: "USD",
            height: "1000px",
            curve: false,
            points: false,
            round: 2,
            zeros: true,
            prefix: "$",
            thousands: ",",
            refresh: 1
          })
}

import "controllers"

