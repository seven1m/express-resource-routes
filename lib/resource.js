_ = require('underscore')
var f = function(p) { return p.replace('//', '/') };

exports.resources = function(app, path, controller) {
  if(controller.index ) app.get   (f(path              ), _.bind(controller.index, controller));
  if(controller.new   ) app.get   (f(path + '/new'     ), _.bind(controller.new,   controller));
  if(controller.show  ) app.get   (f(path + '/:id'     ), _.bind(controller.show,  controller));
  if(controller.edit  ) app.get   (f(path + '/:id/edit'), _.bind(controller.edit,  controller));
  if(controller.create) app.post  (f(path              ), _.bind(controller.create, controller));
  if(controller.update) app.put   (f(path + '/:id'     ), _.bind(controller.update, controller));
  if(controller.delete) app.delete(f(path + '/:id'     ), _.bind(controller.delete, controller));
};

exports.resource = function(app, path, controller) {
  if(controller.new   ) app.get   (f(path + '/new' ), _.bind(controller.new,    controller));
  if(controller.show  ) app.get   (f(path          ), _.bind(controller.show,   controller));
  if(controller.edit  ) app.get   (f(path + '/edit'), _.bind(controller.edit,   controller));
  if(controller.create) app.post  (f(path          ), _.bind(controller.create, controller));
  if(controller.update) app.put   (f(path          ), _.bind(controller.update, controller));
  if(controller.delete) app.delete(f(path          ), _.bind(controller.delete, controller));
};

exports.init = function(app) {
  app.resources = function() { exports.resources.apply(app, [app].concat(Array.prototype.slice.call(arguments))) };
  app.resource  = function() { exports.resource.apply (app, [app].concat(Array.prototype.slice.call(arguments))) };
};
