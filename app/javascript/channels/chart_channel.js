import consumer from "./consumer"



consumer.subscriptions.create( {channel: "charts", room: "BTC_chart"},{
  received(data) {
    document.getElementById("charts").innerHTML = "<div class='chart'>" + data.avg + "</div><div class='chart'>" + data.ask + "</div><div class='chart'>" + data.bid + "</div>";
  }
});
consumer.subscriptions.create( {channel: "charts", room: "ETH_chart"},{
  received(data) {
    document.getElementById("charts").innerHTML = "<div class='chart'>" + data.avg + "</div><div class='chart'>" + data.ask + "</div><div class='chart'>" + data.bid + "</div>";
  }
});
consumer.subscriptions.create( {channel: "charts", room: "LTC_chart"},{
  received(data) {
    document.getElementById("charts").innerHTML = "<div class='chart'>" + data.avg + "</div><div class='chart'>" + data.ask + "</div><div class='chart'>" + data.bid + "</div>";
  }
});
consumer.subscriptions.create( {channel: "charts", room: "XRP_chart"},{
  received(data) {
    document.getElementById("charts").innerHTML = "<div class='chart'>" + data.avg + "</div><div class='chart'>" + data.ask + "</div><div class='chart'>" + data.bid + "</div>";
  }
});

