import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["price"];
  connect() {
    console.log("connected");
  }

  update(event) {
    const price = event.currentTarget.dataset.price;
    const participants = event.currentTarget.value;
    const total = (price * participants).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');;
    this.priceTarget.innerText = total;
  }
}
