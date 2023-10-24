import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["input", "previewContainer", "slides"];
  currentIndex = 0;

  preview() {
    // 既存のプレビュー画像をクリア
    this.slidesTarget.innerHTML = "";

    const files = this.inputTarget.files;

    Array.from(files).forEach((file) => {
      const reader = new FileReader();

      reader.onload = (e) => {
        const img = document.createElement("img");
        img.src = e.target.result;
        img.classList.add("w-full", "h-full");
        this.slidesTarget.appendChild(img);
      };

      reader.readAsDataURL(file);
    });
    this.currentIndex = 0;
    this.updateSlidePosition();

    const previousButton = document.querySelector(
      '[data-action="click->photo-preview#previousSlide"]'
    );
    const nextButton = document.querySelector(
      '[data-action="click->photo-preview#nextSlide"]'
    );

    if (this.inputTarget.files.length > 0) {
      previousButton.classList.remove("hidden");
      nextButton.classList.remove("hidden");
    } else {
      previousButton.classList.add("hidden");
      nextButton.classList.add("hidden");
    }
  }

  updateSlidePosition() {
    this.slidesTarget.style.transform = `translateX(-${
      this.currentIndex * 100
    }%)`;
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
