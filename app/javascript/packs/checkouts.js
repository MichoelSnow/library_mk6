import bc_regex from "./application.js";
import { Modal } from "bootstrap";

$(function () {
  var newAttendee = new Modal(document.getElementById("a-form"), {
    keyboard: false,
  });
  // Make a call to /return when a new barcode is entered.
  $("#g-barcode").on("change", function () {
    var barcode_val = $(this).val();

    if (!bc_regex.test(barcode_val)) {
      $.notify(
        "Invalid barcode format! Barcode should be at least 3 characters long and only contain alphanumeric characters.",
        "warning",
        5000
      );
      $(this).val("");
      return;
    }
    gameBarcode(false);

    $.post("/return", { barcode: barcode_val })
      .done(function (response) {
        if (response.errors) {
          $.each(response.errors, function (k, v) {
            $.notify(v, "danger");
          });
          gameBarcode(true);
        } else if (response.time) {
          $.notify("Successfully returned " + response.game + "!", 5000);
          resetCheckout();
        } else {
          $("#g-name").text("Checking out: " + response.game);
          $("#a-row").show();
          $("#a-barcode").trigger("focus");
        }
      })
      .fail(function () {
        $.notify(DEFAULT_ERROR, "danger");
        gameBarcode(true);
      });
  });

  // Make a call to /attendee/status when a new barcode is entered.
  $("#a-barcode").on("change", function () {
    var barcode_val = $(this).val();

    if (!bc_regex.test(barcode_val)) {
      $.notify(
        "Invalid barcode format! Barcode should be at least 3 characters long and only contain alphanumeric characters.",
        "warning",
        5000
      );
      $(this).val("");
      return;
    }
    attendeeBarcode(false);

    $.get("attendee/status", { barcode: barcode_val })
      .done(function (response) {
        $.post("checkout/new", {
          g_barcode: $("#g-barcode").val(),
          a_barcode: barcode_val,
        })
          .done(function (response) {
            if (response.errors) {
              $.each(response.errors, function (k, v) {
                $.notify(v, "danger");
              });
            } else {
              $.notify("Successfully checked out " + response.game + "!");
              resetCheckout();
            }
            if (response.approval) {
              $.notify(response.approval, "success", 8000);
            }
          })
          .fail(function () {
            $.notify(DEFAULT_ERROR, "danger");
          })
          .always(function () {
            attendeeBarcode(true);
          });
      })
      .fail(function (response) {
        if (response.status == 400) {
          // var myModal = new bootstrap.Modal(document.getElementById('a-form'), options)
          // $("#a-form").show();
          newAttendee.show();
          // $("#a-form").modal();
        } else {
          $.notify(DEFAULT_ERROR, "danger");
          attendeeBarcode(true);
        }
      });
  });

  // Reset the view when the X button is clicked.
  $("#checkouts-x-btn").on("click", function () {
    resetCheckout();
  });

  // Clear all attendee form fields when the form is hidden.
  $("#a-form")
    .on("hidden.bs.modal", function () {
      $("#a-form").find("input").val("");
    })
    .on("shown.bs.modal", function () {
      $("#a-form").find('[name="first_name"]').focus();
    });

  // Hide form, clear attendee barcode field on cancel click.
  $("#a-form-cancel").on("click", function () {
    $("#a-form").modal("hide");
    attendeeBarcode(true);
  });

  // Submit new attendee information. On success, hide form and display new info.
  var saveAttendee = function () {
      var data = $("#a-form").find(".form-control").serializeArray();
      console.log(data);
      data.push({
        name: "barcode",
        value: $("#a-barcode").val(),
      });
      $("#a-form")
        .find("input")
        .parent()
        .removeClass("has-error")
        .find(".glyphicon")
        .hide();
      $.post("attendee/new", data)
        .done(function (response) {
          if (response.attendee) {
            $("#a-form").modal("hide");
            $.post("checkout/new", {
              g_barcode: $("#g-barcode").val(),
              a_barcode: $("#a-barcode").val(),
            })
              .done(function (response) {
                if (response.errors) {
                  $.each(response.errors, function (k, v) {
                    $.notify(v, "danger");
                  });
                } else {
                  $.notify("Successfully checked out " + response.game + "!");
                  resetCheckout();
                }
                if (response.approval) {
                  $.notify(response.approval, "success", 8000);
                }
              })
              .fail(function () {
                $.notify(DEFAULT_ERROR, "danger");
              })
              .always(function () {
                attendeeBarcode(true);
              });
          } else {
            // got errors
            $.each(response.errors, function (k, v) {
              var input = $('[name="' + k + '"]');

              input.parent().addClass("has-error");
              input.siblings(".glyphicon").show();
            });
          }
        })
        .fail(function () {
          console.log("Post Failed")
        });
    },
    saveAttendeeByEnter = function (e) {
      if (e.keyCode === 13 && $("#a-form").is(":visible")) {
        saveAttendee();
      }
    };
  $("#a-form-save").on("click", saveAttendee);
  $("#a-form").find('input[type="text"]').keypress(saveAttendeeByEnter);

  $("#find-barcode").on("change", function () {
    $.get("/find", $(this).serialize(), null, "script");
  });

  $("#found-div").on(".return-game", "click", function () {
    var _me = $(this);
    $.post("/return", { co_id: _me.data("checkout-id") })
      .done(function (response) {
        $.notify("Successfully returned " + response.game + "!", 5000);
        var cell = _me.closest(".col-xs-2");
        cell.html(response.time);
        cell.next().html("RETURNED");
      })
      .fail(function () {
        $.notify(DEFAULT_ERROR, "danger");
      });
  });
});
function gameBarcode(bool) {
  var barcode = $("#g-barcode");

  barcode.prop("disabled", !bool);
  if (bool) {
    barcode.val("").focus();
  }
  $("#checkouts-x-btn").toggle(!bool);
}

function attendeeBarcode(bool) {
  var barcode = $("#a-barcode");

  barcode.prop("disabled", !bool);
  if (bool) {
    barcode.val("").focus();
  }
}

function resetCheckout() {
  gameBarcode(true);
  $("#g-name").text("");
  $("#g-barcode").val("");
  $("#a-row").hide();
}
