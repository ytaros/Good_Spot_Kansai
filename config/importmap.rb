# Pin npm packages by running ./bin/importmap

pin "application", preload: false
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: false
pin "@hotwired/stimulus", to: "https://ga.jspm.io/npm:@hotwired/stimulus@3.2.2/dist/stimulus.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: false
pin_all_from "app/javascript/controllers", under: "controllers"
pin "@fortawesome/fontawesome-free/css/all", to: "node_modules/@fortawesome/fontawesome-free/css/all.css"
pin "@fortawesome/fontawesome-free/js/all", to: "node_modules/@fortawesome/fontawesome-free/js/all.js"
pin "stimulus-autocomplete", to: "https://ga.jspm.io/npm:stimulus-autocomplete@3.1.0/src/autocomplete.js"
pin "google_maps", to: "google_maps.js"
pin "recommend_maps", to: "recommend_maps.js"
pin "jquery", to: "https://ga.jspm.io/npm:jquery@3.6.3/dist/jquery.js"
pin "slick", to: "slick.js"
pin "@rails/ujs", to: "https://ga.jspm.io/npm:@rails/ujs@7.1.2/app/assets/javascripts/rails-ujs.esm.js"
