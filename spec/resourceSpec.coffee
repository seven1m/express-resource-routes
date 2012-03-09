routing = require __dirname + '/../lib/resource'

setupAppSpies = ->
  get:    jasmine.createSpy('get')
  post:   jasmine.createSpy('post')
  put:    jasmine.createSpy('put')
  delete: jasmine.createSpy('delete')

widgetsController =
  index:  jasmine.createSpy('index')
  show:   jasmine.createSpy('show')
  new:    jasmine.createSpy('new')
  edit:   jasmine.createSpy('edit')
  create: jasmine.createSpy('create')
  update: jasmine.createSpy('update')
  delete: jasmine.createSpy('delete')

describe 'routing', ->
  app = null

  describe '.resources', ->
    describe 'with existing actions', ->
      beforeEach ->
        app = setupAppSpies()
        routing.resources(app, '/widgets', widgetsController)

      it 'routes GET /', ->
        expect(app.get).toHaveBeenCalledWith('/widgets', widgetsController.index)

      it 'routes GET /:id', ->
        expect(app.get).toHaveBeenCalledWith('/widgets/:id', widgetsController.show)

      it 'routes GET /new', ->
        expect(app.get).toHaveBeenCalledWith('/widgets/new', widgetsController.new)

      it 'routes GET /:id/edit', ->
        expect(app.get).toHaveBeenCalledWith('/widgets/:id/edit', widgetsController.edit)

      it 'routes POST /', ->
        expect(app.post).toHaveBeenCalledWith('/widgets', widgetsController.create)

      it 'routes PUT /:id', ->
        expect(app.put).toHaveBeenCalledWith('/widgets/:id', widgetsController.update)

      it 'routes DELETE /:id', ->
        expect(app.delete).toHaveBeenCalledWith('/widgets/:id', widgetsController.delete)

    describe 'with missing actions', ->
      beforeEach ->
        app = setupAppSpies()
        nullController = {}
        routing.resources(app, '/widgets', nullController)

      it 'does not route non-existent actions', ->
        expect(app.get).not.toHaveBeenCalled()

    describe 'with a root path', ->
      beforeEach ->
        app = setupAppSpies()
        routing.resources(app, '/', widgetsController)

      it 'routes GET /', ->
        expect(app.get).toHaveBeenCalledWith('/', widgetsController.index)

      it 'routes GET /new', ->
        expect(app.get).toHaveBeenCalledWith('/new', widgetsController.new)


  describe '.resource', ->
    describe 'with existing actions', ->
      beforeEach ->
        app = setupAppSpies()
        routing.resource(app, '/widget', widgetsController)

      it 'routes GET /', ->
        expect(app.get).toHaveBeenCalledWith('/widget', widgetsController.show)

      it 'routes GET /new', ->
        expect(app.get).toHaveBeenCalledWith('/widget/new', widgetsController.new)

      it 'routes GET /edit', ->
        expect(app.get).toHaveBeenCalledWith('/widget/edit', widgetsController.edit)

      it 'routes POST /', ->
        expect(app.post).toHaveBeenCalledWith('/widget', widgetsController.create)

      it 'routes PUT /', ->
        expect(app.put).toHaveBeenCalledWith('/widget', widgetsController.update)

      it 'routes DELETE /', ->
        expect(app.delete).toHaveBeenCalledWith('/widget', widgetsController.delete)

    describe 'with missing actions', ->
      beforeEach ->
        app = setupAppSpies()
        nullController = {}
        routing.resource(app, '/widget', nullController)

      it 'does not route non-existent actions', ->
        expect(app.get).not.toHaveBeenCalled()

    describe 'with a root path', ->
      beforeEach ->
        app = setupAppSpies()
        routing.resource(app, '/', widgetsController)

      it 'routes GET /', ->
        expect(app.get).toHaveBeenCalledWith('/', widgetsController.show)

      it 'routes GET /new', ->
        expect(app.get).toHaveBeenCalledWith('/new', widgetsController.new)

  describe '.init', ->
    beforeEach ->
      routing.init(app)

    it 'sets up resources() and resource() methods on app', ->
      expect(app.resources).toBeDefined()
      expect(app.resource).toBeDefined()
