# faker = Meteor.npmRequire 'faker'

# Meteor.startup ->

# 	db.posts.remove {}

# 	db.posts = _(100).times (i) ->
# 		createdAt: faker.date.recent(100)
# 		author: faker.name.findName()
# 		title: faker.lorem.sentence()
# 		content: faker.lorem.sentences()
# 		amount: faker.finance.amount()

# 	db.posts.batchInsert posts
