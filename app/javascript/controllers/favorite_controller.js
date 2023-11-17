import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["heart", "tooltip"];

  toggleFavorite(event) {
    event.preventDefault();
    const articleId = this.element.dataset.articleIdValue;
    const favoriteId = this.element.dataset.favoriteIdValue;
    const isFavorited = this.heartTarget.classList.contains("text-red-500");

    if (isFavorited) {
      this.unfavorite(articleId, favoriteId);
    } else {
      this.favorite(articleId);
    }
  }

  async favorite(articleId) {
    const response = await fetch(`/articles/${articleId}/favorites`, {
      method: "post",
      headers: {
        "X-CSRF-Token": document.querySelector("[name='csrf-token']").content,
      },
    });

    if (response.ok) {
      const newFavoriteId = await response.text();
      this.element.dataset.favoriteIdValue = newFavoriteId;
      this.heartTarget.classList.add("text-red-500");
      this.updateTooltipText(true);
    } else {
      const errorText = await response.text();
      console.error("Error adding favorite: ", errorText);
    }
  }

  async unfavorite(articleId, favoriteId) {
    const response = await fetch(
      `/articles/${articleId}/favorites/${favoriteId}`,
      {
        method: "delete",
        headers: {
          "X-CSRF-Token": document.querySelector("[name='csrf-token']").content,
        },
      }
    );

    if (response.ok) {
      this.heartTarget.classList.remove("text-red-500");
      this.updateTooltipText(false);
    } else {
      console.error("Error removing favorite");
    }
  }

  updateTooltipText(isFavorited) {
    const newTipText = isFavorited ? "Cancellation!" : "Favorite!";
    this.tooltipTarget.dataset.tip = newTipText;
  }
}
