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
        const formattedDate = date.toDateString().split(' ').slice(1).join(', ')
        templateDay.dataset.date = dateStr;
        templateDay.querySelector('#booking-date-holder').innerText = formattedDate;

        // Needs to fill in the picker on the modal as well
        const pickerInputs = document.querySelectorAll(".flatpickr-input");
        pickerInputs.forEach((picker) => {
          picker.value = dateStr
        })
        const pickerTexts = document.querySelectorAll(".datepicker");
        pickerTexts.forEach((picker) => {
          picker.value = formattedDate
        })
      },
    });
  }

  fillForm(event) {
    // get date from that day's html dataset
    const date = event.target.dataset.date;
    // fill the modal with the date
    // change to target
    document.querySelector("#bookingModal .flatpickr-input").value = date;
    const formattedDate = date.toDateString().split(' ').slice(1).join(', ')
    document.querySelector("#bookingModal .datepicker").value = formattedDate;
  }
}
