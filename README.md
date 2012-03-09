# express-resource-routes

A simple add-on for Express (Node.js) that helps you build routes to represent a RESTful resource.

## Installation

Add `git://github.com/seven1m/express-resource-routes.git` to your package.json dependencies list and run `npm install`.

## Usage

First require the library and call `init(app)`, then you can use either `app.resources()` (plural) or `app.resource()` (singular), e.g.:

```javascript
app = express.createServer();

require('express-resource-routes').init(app);
app.resources('/widgets', {
  index:  function(req, res) { /* ... */ },
  show:   function(req, res) { /* ... */ },
  new:    function(req, res) { /* ... */ },
  edit:   function(req, res) { /* ... */ },
  create: function(req, res) { /* ... */ },
  update: function(req, res) { /* ... */ },
  delete: function(req, res) { /* ... */ }
})
```

You may instead choose to split resource logic into a "controller" and do something more akin to the following:

```javascript
var widgetsController = require('./app/controllers/widgets');
app.resources('/widgets', widgetsController);
```

Inside `app/controllers/widgets.js`:

```javascript
module.exports = {
  index:  function(req, res) { /* ... */ },
  // and so on
}
```
