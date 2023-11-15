import { Controller } from "@hotwired/stimulus";
import { post } from "@rails/request.js";

export default class extends Controller {
  static targets = ["heart", "tooltip"];

  toggleFavorite() {
    event.preventDefault();
    const articleId = this.element.dataset.articleIdValue;
    const favoriteId = this.element.dataset.favoriteIdValue;
    const isFavorited = this.heartTarget.classList.contains("text-red-500");

    if (isFavorited) {
      this.unfavorite(articleId, favoriteId);
    } else {
      this.favorite(articleId);
    }
    this.updateTooltipText(!isFavorited);
  }

  async favorite(articleId) {
    const response = await post(`/articles/${articleId}/favorites`, {
      body: JSON.stringify({ article_id: articleId }),
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": document.querySelector("[name='csrf-token']").content,
      },
    });
    if (response.ok) {
      this.heartTarget.classList.add("text-red-500");
    }
  }

  async unfavorite(articleId, favoriteId) {
    const response = await fetch(
      `/articles/${articleId}/favorites/${favoriteId}`,
      {
        method: "delete",
        headers: {
          "Content-Type": "application/json",
          "X-CSRF-Token": document.querySelector("[name='csrf-token']").content,
        },
      }
    );
    if (response.ok) {
      this.heartTarget.classList.remove("text-red-500");
    }
  }

  updateTooltipText(isFavorited) {
    const newTipText = isFavorited ? "Cancellation!" : "Favorite!";
    this.tooltipTarget.dataset.tip = newTipText;
  }
}
