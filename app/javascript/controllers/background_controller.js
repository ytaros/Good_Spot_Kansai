import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static values = {
    images: Array,
  };
  connect() {
    if (document.body.classList.contains("background-page")) {
      this.loadBackground();
      this.startTransitionInterval();
    }
  }

  disconnect() {
    this.resetBackground();
    if (this.interval) {
      clearInterval(this.interval);
    }
  }

  startTransitionInterval() {
    this.interval = setInterval(() => {
      this.loadBackground();
    }, 5000);
  }

  loadBackground() {
    const randomImage =
      this.imagesValue[Math.floor(Math.random() * this.imagesValue.length)];

    const existingStyle = document.getElementById("dynamic-bg-style");
    if (existingStyle) {
      existingStyle.remove();
    }

    const style = document.createElement("style");
    style.id = "dynamic-bg-style";
    style.innerHTML = `
      body::before {
        content: "";
        position: fixed;
        top: 0;
        right: 0;
        bottom: 0;
        left: 0;
        z-index: -1;
        background-image: url('${randomImage}');
        background-repeat: no-repeat;
        background-size: cover;
        background-position: center;
        opacity: 0.5;
        animation: image-switch-animation 5s infinite;
      }
    `;

    document.head.appendChild(style);
  }

  resetBackground() {
    const existingStyle = document.getElementById("dynamic-bg-style");
    if (existingStyle) {
      existingStyle.remove();
    }
  }
}
