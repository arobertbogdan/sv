== README

This README would normally document whatever steps are necessary to get the
application up and running.

Token endpoint -> localhost:3000/auth/token with application/x-www-form-urlencoded -> email and password

Authorization:
	Header attribute -> Authorization: Token token=[auth_token]


Subscribe / Unsubscribe

	http://localhost:3000/category/[category_id]/subscribe
	Header attribute -> Authorization: Token token=[auth_token]

Posts [GET/POST/PUT]

	GET http://localhost:3000/posts/[post_id].json
	PUT http://localhost:3000/posts/[post_id].json
		Header attribute -> Authorization: Token token=[auth_token]
		application/x-www-form-urlencoded -> title, description, media, category_id
	POST http://localhost:3000/posts.json
		Header attribute -> Authorization: Token token=[auth_token]
		application/x-www-form-urlencoded -> title, description, media, category_id

	DELETE http://localhost:3000/posts/[post_id].json
		Header attribute -> Authorization: Token token=[auth_token]

	PUT http://localhost:3000/posts/[post_id]/[upvode | downvote]
		Header attribute -> Authorization: Token token=[auth_token]

Comments [POST/PUT/DELETE]
	POST http://localhost:3000/posts/[post_id]/comments/reply.json
		Header attribute -> Authorization: Token token=[auth_token]
		application/x-www-form-urlencoded -> parent_id[null for post comment not reply], body
	PUT http://localhost:3000/posts/[post_id]/comments.json
		Header attribute -> Authorization: Token token=[auth_token]
		application/x-www-form-urlencoded -> id, body
	DELETE http://localhost:3000/posts/[post_id]/comments.json
		Header attribute -> Authorization: Token token=[auth_token]
		application/x-www-form-urlencoded -> id
Please feel free to use a different markup language if you do not plan to run
<tt>rake doc:app</tt>.
