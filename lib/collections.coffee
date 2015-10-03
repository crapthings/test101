models = [
	{
		name: 'home'
		path: '/'
		title: '首页'
		data: ['authors', 'posts', 'books']
	}

	{
		collection: 'authors'
		title: '作者'
	}

	{
		collection: 'posts'
		title: '文章'
	}

	{
		collection: 'books'
		title: '书籍'
	}
]

@collections = {}

@db = collections

_.each models, (model) ->

	collection = model.collection

	if collection

		collections[collection] = new Mongo.Collection collection

		if collections[collection].hookOptions

			collections[collection].before.insert (userId, model) ->
				_.extend model,
					createdAt: new Date()
					creatorId: userId

		methods = {}

		methods["#{collection}.insert"] = (opt) ->
			collections[collection].insert opt

		methods["#{collection}.update"] = (id, opt) ->
			collections[collection].update id, $set: opt

		methods["#{collection}.remove"] = (id) ->
			collections[collection].remove id

		Meteor.methods methods

	if Meteor.isClient

		options = {}

		path = model.path || '/' + collection
		template = model.name || collection
		title = model.title || collection

		data = model.data

		if _.isArray data

			options.main = template
			options.title = title

			for item in data
				options[item] = ->
					collections[item].find {}

			console.log options

			route = {}

			route['action'] = ->
				BlazeLayout.render 'layout', options

			FlowRouter.route path, route

		else

			route = {}

			route['action'] = ->
				BlazeLayout.render 'layout',
					main: template
					title: title

			FlowRouter.route path, route
