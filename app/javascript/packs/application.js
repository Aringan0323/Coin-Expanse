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

Rails.start();
Turbolinks.start();
ActiveStorage.start();

$(document).on("turbolinks:load", function() {
    // draggable functionality 
    $("#draggable").draggable();

    // form outlines
    document.querySelectorAll(".form-outline").forEach((formOutline) => {
        new mdb.Input(formOutline).init();
    });

    $("#workspaceDropdownLink")
        .on("mouseenter", () => {
            console.log("hovered");
            $("#workspaceDropdown").addClass("show").attr("aria-expanded", "true");
            $("#workspaceList").addClass("show").attr("data-mdb-popper", "none");
        })
        .on("mouseleave", () => {
            console.log("unhovered");
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
});