# Pin npm packages by running ./bin/importmap

pin "application", preload: false
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: false
pin "@hotwired/stimulus", to: "stimulus.min.js", preload: false
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: false
pin_all_from "app/javascript/controllers", under: "controllers"