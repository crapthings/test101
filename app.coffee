WebApp.connectHandlers.use '/', (req, res, next) ->
	console.log req.headers
	next()
