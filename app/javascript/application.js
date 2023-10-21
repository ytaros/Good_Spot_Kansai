import "@hotwired/turbo-rails";
import { Application } from "@hotwired/stimulus";

import DropdownController from "controllers/dropdown_controller";
import ImagePreviewController from "controllers/image_preview_controller";
import SvgController from "controllers/svg_controller";
import BackgroundController from "controllers/background_controller";

const application = Application.start();

application.register("dropdown", DropdownController);
application.register("image-preview", ImagePreviewController);
application.register("svg", SvgController);
application.register("background", BackgroundController);

application.debug = false;
window.Stimulus = application;

export { application };
