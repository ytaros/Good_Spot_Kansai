import "@hotwired/turbo-rails";
import { Application } from "@hotwired/stimulus";

import DropdownController from "controllers/dropdown_controller";
import AvatarPreviewController from "controllers/avatar_preview_controller";
import SvgController from "controllers/svg_controller";
import BackgroundController from "controllers/background_controller";
import PhotoPreviewController from "controllers/photo_preview_controller";
import AddressController from "controllers/address_controller";
import { Autocomplete } from "stimulus-autocomplete";

const application = Application.start();

application.register("dropdown", DropdownController);
application.register("avatar-preview", AvatarPreviewController);
application.register("photo-preview", PhotoPreviewController);
application.register("svg", SvgController);
application.register("background", BackgroundController);
application.register("address", AddressController);
application.register("autocomplete", Autocomplete);

application.debug = false;
window.Stimulus = application;

export { application };
