import { Controller } from "stimulus";
import flatpickr from "flatpickr";

export default class extends Controller {
  static targets = ["extra", "modal"]
  connect() {
    const extraDays = this.extraTargets;
    flatpickr(".datepicker", {
      altInput: true,
      onChange: function (selectedDates, dateStr, instance) {
        const templateDate = document.querySelector(".template-date");
        const todayDate = document.querySelector(".today-date");
        // remove the extra dates
        extraDays.forEach((target) => {
          target.remove();
        });

        const date = new Date(dateStr);
        const formattedDate = date.toDateString().split(' ').slice(1).join(' ')
        // also update dataset
        templateDate.innerHTML = formattedDate;



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
    const formattedDate = date.toDateString().split(' ').slice(1).join(' ')
    document.querySelector("#bookingModal .datepicker").value = formattedDate;
  }
}
