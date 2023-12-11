import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    window.addEventListener("scroll", this.checkScroll.bind(this));
    this.checkScroll();
  }

  checkScroll() {
    const windowHeight = window.innerHeight;
    const revealPoint = 300;

    if (this.element.getBoundingClientRect().top < windowHeight - revealPoint) {
      this.element.classList.remove("opacity-0");
      this.element.classList.add("animate-fadeInUp");
    }
  }

  disconnect() {
    window.removeEventListener("scroll", this.checkScroll.bind(this));
  }
}
