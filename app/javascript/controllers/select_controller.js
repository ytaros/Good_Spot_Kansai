import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["category", "tag"];

  connect() {
    console.log("Select controller connected");
    this.updateTags();
  }

  updateTags() {
    const categoryId = this.categoryTarget.value;
    const tagSelect = this.tagTarget;
    tagSelect.innerHTML = "";

    const defaultOption = document.createElement("option");
    defaultOption.value = "";
    defaultOption.text = "Tag Select";
    tagSelect.appendChild(defaultOption);

    const url = categoryId
      ? `/tags_for_category?category_id=${categoryId}`
      : "/tags_for_category";

    fetch(url)
      .then((response) => response.json())
      .then((data) => {
        data.forEach((tag) => {
          const option = document.createElement("option");
          option.value = tag.id;
          option.text = tag.name;
          tagSelect.appendChild(option);
        });
      });
  }
}
