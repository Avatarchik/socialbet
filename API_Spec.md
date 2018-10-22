***
***
# REST API Specification

The socialbet API is the corpus callosum connecting the frontend iOS application with the backend Python Flask web server.

This API works via HTTP requests. The mobile application will query the server using HTTP requests in the form of JSON objects. The responses from the server will also be in the form of JSON objects and will be used to render the service on the mobile application.

*Note: these API calls rely on a user-held cookie. The information in this cookie is set on login and presented on every API call in the URI as a query string in the form of* `uid=<logged_in_user_id>&auth=<SHA256(logged_in_user_password)>`. *For sake of brevity, the term `COOKIE` will be used interchangably with the cookie query string.*

| Method      |  URL                        | Action |
|-------------|-----------------------------|--------|
| POST        | `/api/v1/login`             |        |
| GET         |                             |        |
***
***
# JSON Communications Standard

This section describes the contents necessary for each object type. The four main objects that the API must deliver are as follows:

**Bet**
User 1: id, name
User 2: id, name
Value: null or $ amount
Bet_ID
Timestamp
Game: Time, Teams, Path to Logos, Home/Away
\# of Likes
\# of Comments
Description
Live bool
Public/Private

**Comment**
Comment ID
Content of comment
User_ID
Timestamp
\# of likes

**Game**
Sport
DateTime
Home Team: Name, Score, IconPath
Away Team: Name, Score, IconPath
Location

**Profile**
User: ID, Name, Handle
Favorite Team

***
***
# Application Technical Flow

This section describes each of the app's page's interactions with the API through each of the the various functions in the app.

## Splash screen
* When the application has finished loading it will automatically redirect to the **User Login** page.


## User Login
INITIAL RENDER

PAGE UPDATES
* The user can enter their credentials and click submit to send a `POST` request to `/api/v1/accounts/login/`.
	* On success, the API will respond with HTTP code `200 SUCCESS` and the application will store the username and password hash locally as a cookie for authentication for all further requests. The application will automatically redirect to the **Live Bets** page.
	* On failure, the API will respond with HTTP code `401 UNAUTHORIZED` and the application will alert the user that an incorrect username/password was provided and prompt the user to `try again`.
		* If the user clicks `try again`, the page will be refreshed.
		
*Request JSON*
{username:"", password: ""}

*Success Response JSON*
{success_status: "<true/false>", session_id: ""}

LINKS
* The user can click the help button to redirect to the **Help** page.
* The user can click the register button to redirect to the **Account Builder** page.

## Help
INITIAL RENDER
* The application will send a `GET` request to `/api/v1/version/`.
	* On success, the API will respond with HTTP code `200 SUCCESS` and the API version information

PAGE UPDATES

LINKS
* The user can click the back button to redirect to the **User Login** page.

## Account builder
* The user can register an account by providing a username, password, password confirmation, and phone number. The application will submit the information in a `POST` request to `/api/v1/accounts/create/`.
	* On success -- the username is unique -- the API will respond with HTTP code `200 SUCCESS` and the application will store the username and password hash locally as a cookie for authentication for all further requests. The application will then redirect to the contact scraper page.
	* On failure -- the username is taken -- the API will respond with HTTP code `400 BAD REQUEST` and the page will alert the user that this username is taken and prompt the user to `try again`.
		* If the user selects `try again` the page will refresh.
	* TODO phone number confirmation. Maybe a URI call or a confirmation code?

*Requestion JSON*
{username: "", password: "", confirm_password: "", phone_number: "", first_name: "", last_name: ""}

*Response JSON*
{success_status: "", errors: [string]}

##Contact Scraper
INITIAL RENDER

PAGE UPDATES
* TODO how are we going to scrape the phone numbers from the phone?
* Assuming we have the phone numbers, we will submit them in a JSON object (list of phone numbers) via a `POST` request to `/api/v1/accounts/friends/?COOKIE`
	* On success, the API will respond with HTTP code `200 SUCCESS` and the application will redirect to the `Friends` Tab.

*Requestion JSON*
{phone_numbers: [string], session_id: ""}

*Response JSON* 
{success_status: "", errors:[string]}

##Live Bets
INITIAL RENDER
* The application will send a `GET` request to `/api/v1/live/?COOKIE&qty=10`.
	* On success, the API will respond with HTTP code `200 SUCCESS` and the data necessary to render the bets.

PAGE UPDATES
* The user can click the favorite button on a bet by sending a `POST` request to `/api/v1/likes/?betid=<bet id>`.
	* On success, the API will respond with HTTP code `200 SUCCESS` and a **bet** JSON object. Then the application will rerender the bet.

LINKS
* The user can refresh the page by pulling down on the UI. The application will start over with another initial render.
* The user can click a bet event to navigate to the `Bet Viewer` Page.
* The user can click a profile picture on a bet event to navigate to that user's profile page. The application will redirect to the `Profile` Page.

*Requestion JSON*
{session_id:""}

*Response JSON*
*Note:* This JSON returns the information required for *Design 2*. `user1` will be the left hand user in the UI/UX design, and `user2` will be the right hand user.

{
	bets: [
		{
			bet_id: "",
			time_placed: "",
			game_time: "",
			num_comments: int,
			num_likes: int,
			message: "",
			user1: {
				user_id: int,
				first_name: "",
				last_name: "",
				profile_pic_url: "",
				team: "",
				team_logo_url: ""
			},
			user2: {
				user_id: int,
				first_name: "",
				last_name: "",
				profile_pic_url: "",
				team: "",
				team_logo_url: ""
			}
		}
	]

}

##Individual Live Bet
INITIAL RENDER
* The application will send a `GET` request to `/api/v1/live/?bet=<bet_id>`.
	* On success, the API will respond with HTTP code `200 SUCCESS` and the data necessary to render the bets.

*Requestion JSON*
{session_id:""}

*Response JSON*
*Note:* This JSON returns the information required for *Design 2*. `user1` will be the left hand user in the UI/UX design, and `user2` will be the right hand user.

{
	bets: [
		{
			bet_id: "",
			time_placed: "",
			game_time: "",
			num_comments: int,
			num_likes: int,
			message: "",
			user1: {
				user_id: int,
				first_name: "",
				last_name: "",
				profile_pic_url: "",
				team: "",
				team_logo_url: ""
			},
			user2: {
				user_id: int,
				first_name: "",
				last_name: "",
				profile_pic_url: "",
				team: "",
				team_logo_url: ""
			},
			comments: [
				{
					user_id: int,
					first_name: "",
					last_name: "",
					time_commented: "",
					message: "",
					profile_pic_url: ""
				}
			]
		}
	]

}
## Open Bets
INITIAL RENDER
* The application will send a `GET` request to `/api/v1/open/?COOKIE&qty=10`.
	* On success, the API will respond with HTTP code `200 SUCCESS` and the data necessary to render the bets.

PAGE UPDATES
* The user can click the favorite button on a bet by sending a `POST` request to `/api/v1/likes/?betid=<bet id>`.
	* On success, the API will respond with HTTP code `200 SUCCESS` and a **bet** JSON object. Then the application will rerender the bet.

LINKS
* The user can refresh the page by pulling down on the UI. The application will start over with another initial render.
* The user can click a bet event to navigate to the `Bet Viewer` Page.
* The user can click a bet event's handshake icon to initiate accepting the bet. The application will redirect to the `Accept Bet` Page.
* The user can click a profile picture on a bet event to navigate to that user's profile page. The application will redirect to the `Profile` Page.

*Requestion JSON*
{session_id:""}

*Response JSON*
*Note:* This JSON returns the information required for *Design 2*. `user` will be the user who placed the open bet in the UI/UX design.

{
	bets: [
		{
			bet_id: "",
			time_made: "",
			game_time: "",
			num_comments: int,
			num_likes: int,
			message: "",
			amount: int,
			user: {
				user_id: int,
				first_name: "",
				last_name: "",
				profile_pic_url: "",
				team: "",
				team_logo_url: ""
			},
			other_team: "",
			other_team_logo_url: ""
		}
	]

}

## Games
INITIAL RENDER

PAGE UPDATES
* If the user selects a sport, the applicaion will send a 'GET' request to `/api/v1/games/?sport=<sport id>&start=<today>&end=<period end>&qty=10?COOKIE`
	* On success, the API will respond with HTTP code `200 SUCCESS` and all of the games with the provided sport id in the timeframe specified. The application will rerended the page to reflect these changes.

LINKS
* The user can refresh the page by pulling down on the UI. The application will start over with another initial render.
* The user can click `View Open Bets` 
* The user can click `View Live Bets`
* The user can click `Create an Open Bet`
* The user can click `Create an DM Bet`

*Request JSON*
{session_id:""}

*Response JSON*
{games: [
	{
		date: "", 
		games: [
			event_id: int,
			{
				home_team: {
					name: "",
					wins: int,
					losses: int,
					team_logo_url: ""
				},
				away_team: {
					name: "",
					wins: int,
					losses: int,
					team_logo_url: ""
				}
			}
		]
	}
]
}

## "Like" a live bet**
* The user can click the favorite button on a bet by sending a `POST` request to `/api/v1/likes/`.
	* On success, the API will respond with HTTP code `200 SUCCESS` and a **bet** JSON object. Then the application will rerender the bet.

*Requestion JSON*
{session_id: "", bet_id: int}

*Response JSON*
{success_status: ""}

## Comment on a live bet**
* The user can add a comment by filling in the comment box at the bottom of the page and clicking `submit`. This will send a `POST` request to `/api/v1/comment/`.

	* On success, the API will respond with HTTP code `200 SUCCESS` and a **comment** JSON object. Then the application will rerender the comment list.
*Request JSON*
{session_id: "", bet_id:"", message: ""}

*Response JSON*
{
	user_id: int,
	first_name: "",
	last_name: "",
	time_commented: "",
	message: "",
	profile_pic_url: ""
}

LINKS
* The user can refresh the page by pulling down on the UI. The application will start over with another initial render.
* The user can click the handshake icon to initiate accepting the bet. The application will redirect to the `Accept Bet` Page.
* The user can click a profile picture to navigate to that user's profile page. The application will redirect to the `Profile` Page.

## Accept or decline Bet
INITIAL RENDER
* The application will send a `GET` request to `/api/v1/bets/?COOKIE`.
	* On success, the API will respond with HTTP code `200 SUCCESS` and a **bet* JSON object. Then the application will render the bet.

PAGE UPDATES
* The user can accept or decline a bet by sending a `POST` request to `API/v1/bets/accept/`.
	* On success, the API will respond with HTTP code `200 SUCCESS` and a **bet** JSON object. Then the application will rerender the bet.

*Request JSON*
{session_id: "", bet_id: int, accept: "<True/False>"}

*Response JSON*
{success_status: "", errors: []}

## Bet Builder
INITIAL RENDER

PAGE UPDATES

LINKS

* The user can accept or decline a bet by sending a `POST` request to `API/v1/bets/place/`.

*Request JSON*
{sesssion_id: "", event_id: "", amount: int, user_id: float, open_bet: "True/False", proposed_team: ""}

*Response JSON*
{bet_id: int}

## Profile

INITIAL RENDER
* The application will send a GET request to `/api/v1/profile/pid?COOKIE`.
	* On success, the the API will respond with HTTP code `200 SUCCESS` and a **profile** JSON object. The application will then render the profile.
* The application will send a `GET` request to `/api/v1/live/uid?COOKIE`.
	* On success, the the API will respond with HTTP code `200 SUCCESS` and a list of **bet** JSON objects. The application will then render the bet list.

PAGE UPDATES
* The user can click the `Live Bets` Tab by sending a `POST` request to `/api/v1/live/uid?COOKIE`.
	* On success, the the API will respond with HTTP code `200 SUCCESS` and a list of **bet** JSON objects. The application will then render the bet list.
* The user can click the `Open Bets` Tab by sending a `POST` request to `/api/v1/open/uid?COOKIE`.
	* On success, the the API will respond with HTTP code `200 SUCCESS` and a list of **bet** JSON objects. The application will then render the bet list.
* If the user is viewing a friend's profile, they can click the `Between Us` Tab by sending a `POST` request to `/api/v1/profile/between_us/uid?COOKIE`.
	* On success, the the API will respond with HTTP code `200 SUCCESS` and a list of **bet** JSON objects. The application will then render the bet list.
* If the user is viewing their profile, they can click the `History` Tab by sending a `POST` request to `/api/v1/profile/history?COOKIE`.
	* On success, the the API will respond with HTTP code `200 SUCCESS` and a list of **bet** JSON objects. The application will then render the bet list.

LINKS
* The user can refresh the page by pulling down on the UI. The application will start over with another initial render.
* The user can click their friend's count to view their friends list. The application will redirect to the `Friends` page.
* The user can click a bet event to navigate to the bet viewer. The application will redirect to the `Bet Viewer` Page
* The user can click the handshake icon to initiate accepting an open bet. The application will redirect to the `Accept Bet` Page.
* The user can click the back button to exit the `Profile` page. The application will redirect to the previous page.
* The user can click a profile picture to navigate to that user's profile page. The application will redirect to the `Profile` Page.
* To propose direct bet against this user, send POST request to `API/v1/bets/place/`

*Request JSON*
{session_id: "", user_id: int}

*Response JSON*
{first_name: "", last_name: "", user_name: "", profile_pic_url: ""}

## Friends
INITIAL RENDER

PAGE UPDATES

LINKS
*Request JSON*
{session_id: ""}

*Response JSON*
{friends: [
	{
		user_id: int,
		first_name: "",
		last_name: "",
		user_name: "",
		profile_pic_url: ""
	}
	]
}

***
***
