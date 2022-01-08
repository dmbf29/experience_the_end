import { Controller } from "stimulus";
import flatpickr from "flatpickr";

export default class extends Controller {
  static targets = ["extra", "modal", "template"];
  connect() {
    const templateDay = this.templateTarget;
    const extraDays = this.extraTargets;
    flatpickr(".datepicker", {
      // disable past

      altInput: true,
      onChange: function (selectedDates, dateStr, instance) {

        // remove the extra days
        extraDays.forEach((target) => {
          target.remove();
        });

        // update the one day remaining with new date
        const date = new Date(dateStr);
        let formattedDate = date.toDateString().split(' ').slice(1)
        formattedDate = formattedDate[0] + ' ' + formattedDate[1] + ', ' + formattedDate[2]
        templateDay.dataset.date = dateStr;
        templateDay.querySelector("button").dataset.date = dateStr;
        templateDay.querySelector('#booking-date-holder').innerText = formattedDate;
      },
    });
  }

  fillModalForm(event) {
    // get date from that day's html dataset
    const dateStr = event.currentTarget.dataset.date;
    const date = new Date(dateStr);
    // Hidden flatpickr input
    this.modalTarget.querySelector(".flatpickr-input").value = date;
    // const formattedDate = date.toDateString().split(' ').slice(1).join(', ')
    let formattedDate = date.toDateString().split(' ').slice(1)
    formattedDate = formattedDate[0] + ' ' + formattedDate[1] + ', ' + formattedDate[2]
    // Input user sees
    this.modalTarget.querySelector(".datepicker.input").value = formattedDate;
  }
}
