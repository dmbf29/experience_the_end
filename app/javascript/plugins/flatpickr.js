import flatpickr from "flatpickr";

const initFlatpickr = () => {
  flatpickr(".datepicker", {
    altInput: true,
    onChange: function (selectedDates, dateStr, instance) {
      const templateDate = document.querySelector(".template-date");
      const todayDate = document.querySelector(".today-date");
      todayDate.style.display = "none";
      templateDate.innerHTML = dateStr;

    },
  });
}

export { initFlatpickr };
