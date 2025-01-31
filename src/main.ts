import { createApp } from "vue"
import "vuetify/styles"
import { createVuetify } from "vuetify"

import * as components from "vuetify/components"
import * as directives from "vuetify/directives"
import "@mdi/font/css/materialdesignicons.css"
import App from "./App.vue"

const protonCarbonTheme = {
    dark: true,
    colors: {
        background: "#16141c",
        surface: "#6200EE",
        primary: "#6200EE",
        secondary: "#FFFFFF",
        error: "#f5385a",
        info: "#239ece",
        success: "#1ea885",
        warning: "#ff9900"
    }
}

const vuetify = createVuetify({
    components,
    directives,
    icons: {
        defaultSet: "mdi"
    },
    theme: {
        defaultTheme: "dark",
        themes: {
            protonCarbonTheme
        }
    }
})

createApp(App).use(vuetify).mount("#app")
