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

	GET http://localhost:3000/posts/1.json
	PUT http://localhost:3000/posts/1.json
		Header attribute -> Authorization: Token token=[auth_token]
		application/x-www-form-urlencoded -> title, description, media, category_id
	POST http://localhost:3000/posts.json
		Header attribute -> Authorization: Token token=[auth_token]
		application/x-www-form-urlencoded -> title, description, media, category_id

Please feel free to use a different markup language if you do not plan to run
<tt>rake doc:app</tt>.
