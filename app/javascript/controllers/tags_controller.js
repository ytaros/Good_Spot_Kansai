import { Controller } from "@hotwired/stimulus";
import Rails from "@rails/ujs";

export default class extends Controller {
  static targets = ["category", "tag"];

  updateTags(event) {
    const category_id = event.target.value;
    const tagSelect = document.getElementById("tag_select");

    Rails.ajax({
      type: "GET",
      url: `/categories/${category_id}/tags`,
      dataType: "json",
      success: (data) => {
        tagSelect.innerHTML =
          '<option value="">タグを選択してください</option>';
        data.forEach((tag) => {
          const option = document.createElement("option");
          option.value = tag.id;
          option.text = tag.name;
          tagSelect.appendChild(option);
        });
      },
      error: (err) => {
        console.error(err);
      },
    });
  }
}
