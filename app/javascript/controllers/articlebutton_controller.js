import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["articlesContainer"];

  loadArticles(event) {
    event.preventDefault();

    const articlesContainer = document.getElementById("articles-container");
    articlesContainer.classList.toggle("hidden");
  }
}
