import flatpickr from "flatpickr";

const initFlatpickr = () => {
  flatpickr(".datepicker", {
    altInput: true,
    onChange: function (selectedDates, dateStr, instance) {
      const templateDate = document.querySelector(".template-date");
      const todayDate = document.querySelector(".today-date");
      todayDate.style.display = "none";
      const date = new Date(dateStr);
      const formattedDate = date.toDateString().split(' ').slice(1).join(' ')
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

export { initFlatpickr };
