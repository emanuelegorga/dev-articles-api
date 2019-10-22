Overview of Dev Articles API
---

Features
---

- Listing recent Articles
- Previewing the article's details
- Registering new users using login/password flow
- Logging in using login and encrypted password flow
- OAUTH integration with Github
- Managing own articles (Create/Update/Destroy)
- Creating comments to articles
- Serializing responses
- Used TDD
- Deployed it on Heroku => 'https://dev-articles-api.herokuapp.com/'

---

Endpoints:
---

- sign_up => post '/sign_up'

You will need to choose an username and a password:

SIGN UP REQUEST BODY:
```json
{
	"data": {
		"attributes": {
			"login": "emanuele",
			"password": "secret"
		}
	}
}
```

SIGN UP RESPONSE:
```json
{
  "id": 4,
  "login": "emanuele_3",
  "name": null,
  "url": null,
  "avatar_url": null,
  "provider": "standard",
  "created_at": "2019-10-22T19:02:43.867Z",
  "updated_at": "2019-10-22T19:02:43.867Z",
  "encrypted_password": "$2a$12$Tx/ahhI7GZ.kKKif1xZE1.w17QNm2ALNvUvE20ymqR6TNrmT6cQEy"
}
```
---

Once signed up, you can now login:

- login => post '/login'

LOGIN REQUEST BODY:
```json
{
	"data": {
		"attributes": {
			"login": "emanuele",
			"password": "secret"
		}
	}
}
```

LOGIN RESPONSE:
```json
{
  "data": {
      "id": "3",
      "type": "access_token",
      "attributes": {
          "id": 3,
          "token": "c61756a2d7c50f12c1dc"
      }
  }
}
```
---

- logout => delete '/logout'
</br>
To logout you only need to pass the token given in the login response as Bearer token

---

- create an articles => post '/articles'
</br>
To create an article you will need to be logged in and pass the token given from the login response as Bearer token

CREATE ARTICLE REQUEST BODY:
```json
{
	"data": {
		"attributes": {
			"content": "Test content 2",
			"title": "Test title 2",
			"slug": "test-title 2"
		}
	}
}
```

CREATE ARTICLE RESPONSE:
```json
{
  "data": {
      "id": "5",
      "type": "article",
      "attributes": {
          "id": 5,
          "title": "Test title 2",
          "content": "Test content 2",
          "slug": "test-title 2"
      }
  }
}
```

---

- fetch an article => get '/articles/1'

FETCH AN ARTICLE RESPONSE:
```json
{
  "data": {
      "id": "1",
      "type": "article",
      "attributes": {
          "id": 1,
          "title": "Article title 1",
          "content": "Article content 1",
          "slug": "Article slug 1"
      }
  }
}
```

---

- create a comment => post '/articles/1/comments'
</br>
To create a comment you will need to be logged in, create an article and pass the token given from the login response as Bearer token

CREATE A COMMENT REQUEST BODY:
```json
{
	"data": {
		"attributes": {
			"content": "Test content 3"
		}
	}
}
```

CREATE A COMMENT RESPONSE:
```json
{
  "data": {
      "id": "1",
      "type": "comment",
      "attributes": {
          "id": 1,
          "content": "Test content 3"
      },
      "relationships": {
          "article": {
              "data": {
                  "id": "1",
                  "type": "article"
              }
          },
          "user": {
              "data": {
                  "id": "4",
                  "type": "user"
              }
          }
      }
  }
}
```

---

- fetch a comment => get '/articles/1/comments'

FETCH A COMMENT RESPONSE:
```json
{
  "data": [
      {
          "id": "1",
          "type": "comment",
          "attributes": {
              "id": 1,
              "content": "Test content 3"
          },
          "relationships": {
              "article": {
                  "data": {
                      "id": "1",
                      "type": "article"
                  }
              },
              "user": {
                  "data": {
                      "id": "4",
                      "type": "user"
                  }
              }
          }
      }
  ]
}
```
