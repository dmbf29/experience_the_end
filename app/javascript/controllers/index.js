// Load all the controllers within this directory and all subdirectories.
// Controller files must be named *_controller.js.

import { Application } from "stimulus"
import { definitionsFromContext } from "stimulus/webpack-helpers"
import Lightbox from "stimulus-lightbox"

const application = Application.start()
const context = require.context("controllers", true, /_controller\.js$/)
application.register("lightbox", Lightbox)
application.load(definitionsFromContext(context))
