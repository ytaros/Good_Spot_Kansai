import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["slides"];
  currentIndex = 0;

  // スライドを更新するメソッド
  updateSlidePosition() {
    this.slidesTarget.style.transform = `translateX(-${
      this.currentIndex * 500
    }px)`; // ここでの500は画像の幅に合わせて調整
  }

  // 前のスライドへ移動
  previousSlide() {
    if (this.currentIndex > 0) {
      this.currentIndex--;
      this.updateSlidePosition();
    }
  }

  // 次のスライドへ移動
  nextSlide() {
    if (this.currentIndex < this.slidesTarget.children.length - 1) {
      this.currentIndex++;
      this.updateSlidePosition();
    }
  }
}
