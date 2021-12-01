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
import "chartkick/highcharts";
import "chartkick"
import "controllers";
import _ from "lodash";
// import "html-to-json"
Rails.start();
Turbolinks.start();
ActiveStorage.start();

$(document).on("turbolinks:load", function() {
    // draggable functionality 
    $("div[id*='-draggable']").draggable({
        containment: '.create-cards',
        scroll: true,
        scrollSensitivity: 40,
        scrollSpeed: 40
    });

    $("div[id*='-resizable']").resizable();

    // form outlines
    document.querySelectorAll(".form-outline").forEach((formOutline) => {
        new mdb.Input(formOutline).init();
    });

    $("#workspaceDropdownLink")
        .on("mouseenter", () => {
            $("#workspaceDropdown").addClass("show").attr("aria-expanded", "true");
            $("#workspaceList").addClass("show").attr("data-mdb-popper", "none");
        })
        .on("mouseleave", () => {
            // link
            $("#workspaceDropdown")
                .removeClass("show")
                .attr("aria-expanded", "false");

            // list
            $("#workspaceList").removeClass("show").removeAttr("data-mdb-popper");
        });

    $("#workspaceList")
        .on("mouseleave", () => {
            // link
            $("#workspaceDropdown")
                .removeClass("show")
                .attr("aria-expanded", "false");

            // list
            $("#workspaceList").removeClass("show").removeAttr("data-mdb-popper");
        })
        .on("mouseenter", () => {
            $("#workspaceDropdown").addClass("show").attr("aria-expanded", "true");
            $("#workspaceList").addClass("show").attr("data-mdb-popper", "none");
        });

    $('#create-strat').on('click', (e) => {
        e.preventDefault();
        const name = $('#strategy_name').val();
        const coin = $('#coin_coin_id option:selected').text();
        const data = mapDOM(document.getElementById('create-cards'), false);
        const type = $('#buy-radio').attr('checked') ? 'BUY' : 'SELL';
        const rawHtml = $('#create-cards').html();
        const quantity = $("#quantity").val();
        console.log(quantity)
        console.log(data)
        $.ajax({
            type: "POST",
            url: "/strategies/new",
            data: { html_raw: rawHtml, name: name, coin: coin, type: type, data: data, quantity: quantity },
            success: (resp) => console.log(resp),
            error: (err) => console.error(err)
        })
    });
    // form outlines
    document.querySelectorAll(".form-outline").forEach((formOutline) => {
        new mdb.Input(formOutline).init();
    });

    // create each chart for a coin
    document.querySelectorAll(".show_charts").forEach((charts) => {
        const coin_id = $(charts).attr("id");
        create_chart("avg-chart", "/chart_data/avg?id=" + coin_id)
        create_chart("ask-chart", "/chart_data/ask?id=" + coin_id)
        create_chart("bid-chart", "/chart_data/bid?id=" + coin_id)
    })

    // create average price charts for all coins
    document.querySelectorAll(".index_charts").forEach((avgChart) => {
        const coin_ids = $(avgChart).children();
        console.log(coin_ids)
        coin_ids.each(
            function(child) {
                if (child % 2 == 1) {
                    const coin_id = $(coin_ids[child]).attr("id");
                    const url = "/chart_data/avg?id=" + coin_id;
                    create_chart(coin_id, url)
                }

            }
        )

    })
});

function create_chart(id, url) {
    return new Chartkick.LineChart(id, url, {
        code: true,
        adapter: "highcharts",
        height: "800px",
        width: "1000px",
        min: null,
        ytitle: "USD",
        curve: false,
        points: false,
        round: 2,
        zeros: true,
        prefix: "$",
        thousands: ",",
        refresh: 1,
        library: {
            container: {
                plotOptions: {
                    series: { pointIntervalUnit: "minute" }
                },
                chart: {
                    backgroundColor: "#262626",
                    boarderColor: "#03a8a3"
                }
            }


        }
    })
}

function mapDOM(element, json) {
    var treeObject = {};

    // If string convert to document Node
    if (typeof element === "string") {
        if (window.DOMParser) {
            parser = new DOMParser();
            docNode = parser.parseFromString(element, "text/xml");
        } else { // Microsoft strikes again
            docNode = new ActiveXObject("Microsoft.XMLDOM");
            docNode.async = false;
            docNode.loadXML(element);
        }
        element = docNode.firstChild;
    }

    //Recursively loop through DOM elements and assign properties to object
    function treeHTML(element, object) {
        object["type"] = element.nodeName;
        var nodeList = element.childNodes;
        if (nodeList != null) {
            if (nodeList.length) {
                object["content"] = [];
                for (var i = 0; i < nodeList.length; i++) {
                    if (nodeList[i].nodeType == 3 && !/[s+\n+]/.test(nodeList[i].nodeValue)) {
                        object["content"].push(nodeList[i].nodeValue);
                    } else {
                        object["content"].push({});
                        treeHTML(nodeList[i], object["content"][object["content"].length - 1]);
                        filterLast(object["content"]);
                    }
                }
            }
        }
        if (element.attributes != null) {
            if (element.attributes.length) {
                object["attributes"] = {};
                for (var i = 0; i < element.attributes.length; i++) {
                    object["attributes"][element.attributes[i].nodeName] = element.attributes[i].nodeValue;
                }
            }
        }
    }
    treeHTML(element, treeObject);

    return (json) ? JSON.stringify(treeObject) : treeObject;
}

function filterLast(html) {
    const important = ['SELECT', 'INPUT'];
    const last = html.at(-1);
    if (_.isEqual({ type: '#text' }, last)) {
        html.splice(-1)
    } else if (!last.attributes) {
        html.splice(-1)
    } else if (last.attributes.id && last.attributes.id.includes('title')) {
        html.splice(-1)
    } else if (!important.includes(last.type) && (!last.content || !last.content.length)) {
        html.splice(-1)
    }
}