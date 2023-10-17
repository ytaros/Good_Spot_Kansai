import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["path"];

  handleMouseOver(event) {
    const pathElement = event.currentTarget;
    const color = pathElement.getAttribute("data-color");
    pathElement.setAttribute("style", `fill: ${color}`);
  }

  handleMouseOut(event) {
    const pathElement = event.currentTarget;
    pathElement.setAttribute("style", "fill: none");
  }
}
