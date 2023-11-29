import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["slides"];
  currentIndex = 0;

  updateSlidePosition() {
    this.slidesTarget.style.transform = `translateX(-${
      this.currentIndex * 500
    }px)`;
  }

  previousSlide() {
    if (this.currentIndex > 0) {
      this.currentIndex--;
      this.updateSlidePosition();
    }
  }

  nextSlide() {
    if (this.currentIndex < this.slidesTarget.children.length - 1) {
      this.currentIndex++;
      this.updateSlidePosition();
    }
  }
}
