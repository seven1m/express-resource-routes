var f = function(p) { return p.replace('//', '/') };

exports.resources = function(app, path, controller) {
  if(controller.index ) app.get   (f(path              ), controller.index );
  if(controller.show  ) app.get   (f(path + '/:id'     ), controller.show  );
  if(controller.new   ) app.get   (f(path + '/new'     ), controller.new   );
  if(controller.edit  ) app.get   (f(path + '/:id/edit'), controller.edit  );
  if(controller.create) app.post  (f(path              ), controller.create);
  if(controller.update) app.put   (f(path + '/:id'     ), controller.update);
  if(controller.delete) app.delete(f(path + '/:id'     ), controller.delete);
};

exports.resource = function(app, path, controller) {
  if(controller.show  ) app.get   (f(path          ), controller.show  );
  if(controller.new   ) app.get   (f(path + '/new' ), controller.new   );
  if(controller.edit  ) app.get   (f(path + '/edit'), controller.edit  );
  if(controller.create) app.post  (f(path          ), controller.create);
  if(controller.update) app.put   (f(path          ), controller.update);
  if(controller.delete) app.delete(f(path          ), controller.delete);
};

exports.init = function(app) {
  app.resources = function() { exports.resources.apply(app, [app].concat(Array.prototype.slice.call(arguments))) };
  app.resource  = function() { exports.resource.apply (app, [app].concat(Array.prototype.slice.call(arguments))) };
};
