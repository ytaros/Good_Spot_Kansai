import { Application } from "@hotwired/stimulus";
import "@hotwired/turbo-rails";
import "google_maps";
import "recommend_maps";
import "slick";
import Rails from "@rails/ujs";
Rails.start();

import DropdownController from "controllers/dropdown_controller";
import AvatarPreviewController from "controllers/avatar_preview_controller";
import SvgController from "controllers/svg_controller";
import BackgroundController from "controllers/background_controller";
import PhotoPreviewController from "controllers/photo_preview_controller";
import AddressController from "controllers/address_controller";
import TagsController from "controllers/tags_controller";
import SelectController from "controllers/select_controller";
import FlashController from "controllers/flash_controller";
import FavoriteController from "controllers/favorite_controller";
import { Autocomplete } from "stimulus-autocomplete";

const application = Application.start();

application.register("dropdown", DropdownController);
application.register("avatar-preview", AvatarPreviewController);
application.register("photo-preview", PhotoPreviewController);
application.register("svg", SvgController);
application.register("background", BackgroundController);
application.register("address", AddressController);
application.register("tags", TagsController);
application.register("select", SelectController);
application.register("flash", FlashController);
application.register("favorite", FavoriteController);
application.register("autocomplete", Autocomplete);

application.debug = false;
window.Stimulus = application;

export { application };
