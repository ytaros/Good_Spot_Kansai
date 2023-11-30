import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["path"];

  connect() {
    this.tooltip = document.createElement("div");
    this.tooltip.style.position = "absolute";
    this.tooltip.style.display = "none";
    this.tooltip.className =
      "bg-indigo-300 text-white py-2 px-4 rounded-lg shadow-md text-sm";

    document.body.appendChild(this.tooltip);
    window.addEventListener("pageshow", this.resetElements.bind(this));
    this.pathTargets.forEach((path) => {
      path.addEventListener("click", this.resetOnClick.bind(this));
    });
  }

  handleMouseOver(event) {
    const pathElement = event.currentTarget;
    const color = pathElement.getAttribute("data-color");
    const name = pathElement.getAttribute("data-name");

    pathElement.setAttribute("style", `fill: ${color}`);

    this.tooltip.innerHTML = name;
    this.tooltip.style.display = "block";
    this.tooltip.style.left = `${event.clientX}px`;
    this.tooltip.style.top = `${event.clientY}px`;
  }

  handleMouseOut(event) {
    const pathElement = event.currentTarget;
    pathElement.setAttribute("style", "fill: none");

    this.tooltip.style.display = "none";
  }

  resetElements() {
    this.pathTargets.forEach((pathElement) => {
      pathElement.setAttribute("style", "fill: none");
    });
    this.tooltip.style.display = "none";
  }
  resetOnClick(event) {
    // クリックされた要素の色とツールチップをリセット
    const pathElement = event.currentTarget;
    pathElement.setAttribute("style", "fill: none");
    this.tooltip.style.display = "none";
  }
}
