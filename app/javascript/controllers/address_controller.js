import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["citySelect", "addressInput", "areaName"];

  updateAddress() {
    const cityName =
      this.citySelectTarget.options[this.citySelectTarget.selectedIndex].text;
    const areaName = this.areaNameTarget.value;

    this.addressInputTarget.value = `${areaName}${cityName}`;
  }
}
