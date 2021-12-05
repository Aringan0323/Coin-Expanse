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

$(document).on("turbolinks:load", function () {

    $('select').each(function (_index, _id) {
        // used for loading an edit function
        const id = $(this).attr('id');

        const expected = $(this).attr('value');

        if (id && expected) {
            $(this).children('option').toArray().forEach(option => {
                const text = $(option).text();
                let change = false;
                if (text === expected) {
                    change = true;
                }
                $(option).prop('selected', change)
            });
        }
    });

    $('.alert').fadeTo(2500, 0, function () {
        $('.alert').slideUp(750);
    });

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
        const coin = $('#strategy_coin option:selected').text();
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

    $('#update-strat').on('click', (e) => {
        e.preventDefault();
        const name = $('#strategy_name').val();
        const coin = $('#strategy_coin option:selected').text();
        const data = mapDOM(document.getElementById('create-cards'), false);
        const type = $('#buy-radio').attr('checked') ? 'BUY' : 'SELL';
        const rawHtml = $('#create-cards').html();
        const quantity = $("#quantity").val();
        const id = $('#strat-id').text();
        console.log(id)
        $.ajax({
            type: "POST",
            url: `/strategies/edit/${id}`,
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
    document.querySelectorAll(".chart").forEach((charts) => {
        const coin_id = $(charts).attr("id");
        create_chart(coin_id, "/chart_data/price?id=" + coin_id)
    })

    document.querySelectorAll(".bar_chart").forEach((charts) => {
        const ind_id = $(charts).attr("id");
        create_bar(ind_id, "/indicator/data?name=" + ind_id + "&interval=1h")
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
        refresh: 15,
        colors: ["rgb(117, 16, 232)", "rgb(16, 138, 232)", "rgb(158, 0, 0)"],
        library: {
            chart: {
                backgroundColor: "rgb(38,38,38)",
                boarderColor: "rgb(0,0,0)",
                zoomType: "x"

            },
            legend: {
                itemStyle: {
                    "color": "rgb(255,255,255)",
                    "fontSize": "17px"

                }
            },
            loading: {
                showDuration: 0
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


