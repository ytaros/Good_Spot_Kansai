# Pin npm packages by running ./bin/importmap

pin "application", preload: false
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: false
pin "@hotwired/stimulus", to: "stimulus.min.js", preload: false
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: false
pin_all_from "app/javascript/controllers", under: "controllers"
pin "@fortawesome/fontawesome-free/css/all", to: "node_modules/@fortawesome/fontawesome-free/css/all.css"
pin "@fortawesome/fontawesome-free/js/all", to: "node_modules/@fortawesome/fontawesome-free/js/all.js"
