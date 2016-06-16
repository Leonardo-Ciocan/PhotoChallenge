#Documentation

##Authentication

To signup , post `username` and `password` to `/signup/`. Log in afterwards if successful:

Post `username` and `password` to `/token/` and you will receive a json object with one element `token` inside it. A token is a string that you can attach to all later requests so the server knows who is logged in.

To authenticate further requests add a header with key `Authorization` and value `Token <token>` where `<token>` is the token you got from the `/token` endpoint

##Endpoints
###Categories
Endpoint `/categories/`

```
[
  {
    "id" : 0,
    "stars" : 0,
    "name" : "Animals",
    "color" : "0,186,0"
  },
  
  {
    "id" : 1,
    "stars" : 0,
    "name" : "Places",
    "color" : "3,163,243"
  }
]
```


###Challenges
Endpoint `/challenges/<id>` where `<id>` is the id of a category

```
[
	{
	  "tag" : "Easy",
	  "id" : 0,
	  "hasSubmission" : true,
	  "name" : "Cat"
	},
	
	{
	  "tag" : "Easy",
	  "id" : 1,
	  "hasSubmission" : false,
	  "name" : "Dog"
	}
]
```

###Challenge submission
If the user submitted an image for a challenge (check the `hasSubmission` field on the `/challenges/` endpoint) you can get that image by getting the `/image/<id>` endpoint where `<id>` is the id of the challenge

###Submitting images
Upload an image to `/challenges/<id>` where `<id>` is the challenge you're submitting for. The image upload key should be "file"

###Friends
GET `friends` to get all friends:

```
[
  {
    "stars" : 0,
    "name" : "jake"
  },
  {
    "stars" : 2,
    "name" : "leonardo"
  }
]
```

POST `friends` with a `username` to add a friend with that username. It will return 200 only if the user was found.