import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["input", "previewContainer", "slides"];
  currentIndex = 0;
  croppers = []; // Cropperインスタンスを保持する配列

  preview() {
    this.resetCroppers();
    this.slidesTarget.innerHTML = "";
    const files = this.inputTarget.files;

    Array.from(files).forEach((file, index) => {
      const reader = new FileReader();

      reader.onload = (e) => {
        const img = document.createElement("img");
        img.src = e.target.result;
        img.classList.add("w-full", "h-full", "slide");
        this.slidesTarget.appendChild(img);

        // ここでモーダルウィンドウを開く
        this.openCropperModal(file); // モーダルを開くメソッドを呼び出す
      };

      reader.readAsDataURL(file);
    });

    this.updateSliderButtons();
  }

  initializeCropper(imageElement, index) {
    this.croppers[index] = new Cropper(imageElement, {
      // Cropperのオプション
      aspectRatio: 16 / 9,
      // その他のオプション
    });
  }

  resetCroppers() {
    this.croppers.forEach((cropper) => {
      if (cropper) {
        cropper.destroy();
      }
    });
    this.croppers = [];
  }

  updateSliderButtons() {
    // スライダーボタンの表示を更新
    const previousButton = document.querySelector(
      '[data-action="click->photo-preview#previousSlide"]'
    );
    const nextButton = document.querySelector(
      '[data-action="click->photo-preview#nextSlide"]'
    );

    if (this.inputTarget.files.length > 1) {
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

  getCroppedImages() {
    return this.croppers
      .map((cropper) => {
        return cropper ? cropper.getCroppedCanvas().toDataURL() : null;
      })
      .filter(Boolean);
  }

  openCropperModal(file) {
    const modal = document.getElementById("cropperModal");
    const imageToCrop = document.getElementById("imageToCrop");
    const cropButton = document.getElementById("cropButton");

    // FileReaderを使って画像のURLを生成
    const reader = new FileReader();
    reader.onload = function (e) {
      imageToCrop.src = e.target.result;
      modal.classList.remove("hidden"); // モーダルを表示

      // Cropper.jsを初期化、アスペクト比を1（正方形）に設定
      const cropper = new Cropper(imageToCrop, {
        aspectRatio: 1,
        viewMode: 1, // 画像がコンテナからはみ出さないようにする
        // その他のオプション...
      });

      // トリミングボタンのイベントハンドラを設定
      cropButton.onclick = function () {
        const croppedCanvas = cropper.getCroppedCanvas({
          width: 500, // トリミング後の幅
          height: 500, // トリミング後の高さ
        });
        const croppedImage = croppedCanvas.toDataURL();
        // ここでトリミングされた画像データを処理、例えばinput要素のvalueにセットするなど
        cropper.destroy(); // Cropperインスタンスを破棄
        modal.classList.add("hidden"); // モーダルを非表示にする
      };
    };
    reader.readAsDataURL(file);
  }

  updateCroppedPreview(croppedDataUrl) {
    const img = document.createElement("img");
    img.src = croppedDataUrl;
    img.classList.add("w-full", "h-full", "cropped-preview");
    this.previewContainerTarget.appendChild(img);
  }

  connect() {
    if (!this.previewContainerTarget.dataset.photos) {
      return;
    }

    const photoUrls = this.previewContainerTarget.dataset.photos.split(",");

    if (photoUrls[0] === "") {
      this.hideSliderButtons();
    } else {
      this.loadExistingPhotos();
    }
  }

  hideSliderButtons() {
    document
      .querySelector('[data-action="click->photo-preview#previousSlide"]')
      .classList.add("hidden");
    document
      .querySelector('[data-action="click->photo-preview#nextSlide"]')
      .classList.add("hidden");
  }
  loadExistingPhotos() {
    const photoUrls = this.previewContainerTarget.dataset.photos.split(",");
    if (photoUrls.length === 0) return; // 追加: photoUrlsが空の場合は処理を終了

    photoUrls.forEach((url) => {
      const img = document.createElement("img");
      img.src = url;
      img.classList.add("w-full", "h-full");
      this.slidesTarget.appendChild(img);
    });

    if (photoUrls.length > 0) {
      document
        .querySelector('[data-action="click->photo-preview#previousSlide"]')
        .classList.remove("hidden");
      document
        .querySelector('[data-action="click->photo-preview#nextSlide"]')
        .classList.remove("hidden");
    }
  }
}
