Template.registerHelper 'formatDate', (date, format) ->
	moment(new Date(date)).format(format)

Template.registerHelper 'fromNow', (date) ->
	moment(new Date(date)).fromNow()
