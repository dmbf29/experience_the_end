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
    },
  });
}

export { initFlatpickr };
