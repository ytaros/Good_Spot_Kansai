import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    this.playVideo();
  }

  playVideo() {
    this.element.play();
  }
}
