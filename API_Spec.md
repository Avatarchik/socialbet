***
***
# REST API Specification

The socialbet API is the corpus callosum connecting the frontend iOS application with the backend Python Flask web server.

This API works via HTTP requests. The mobile application will query the server using HTTP requests in the form of JSON objects. The responses from the server will also be in the form of JSON objects and will be used to render the service on the mobile application.

| Method      |  URL                        | Action |
|-------------|-----------------------------|--------|
| POST        | `/api/v1/login`             |        |
| GET         |                             |        |
***
***
# JSON Communications Standard

This section describes the contents necessary for each object type. The four main objects that the API must deliver are as follows:

**Bet**
TODO create JSON object

**Comment**
TODO create JSON object

**Game**
TODO create JSON object

**Profile**
TODO create JSON object

***
***
# Application Technical Flow

This section describes the mobile application frontend in terms of the subprocesses that will allow the pages to be rendered.

**Splash screen**
* When the application has finished loading it will automatically redirect to the **User Login** page

**User Login**
* A user can submit login credentials via a `POST` request to `/api/v1/login/`. 
    * On success, the API will respond with HTTP code `200 SUCCESS` and the application will store the username and password hash locally as a cookie for authentication for all further requests. The application will automatically redirect to the **Live Bets** page
    * On failure, the API will respond with HTTP code `401 UNAUTHORIZED` and the application will alert the user that an incorrect username/password was provided and prompt the user to `try again`.
        * If the user selects `try again` the page will refresh.
* A user can click the register button to redirect to the **Account Builder** page.

**Account builder**
* If the user provides matching passwords along with their username, the application will send the username and password in a `POST` request to `/api/v1/accounts/create/`.
    * On success -- the username is unique and the passwords match -- the API will respond with HTTP code `200 SUCCESS` and the application will redirect to the contact scraper page.
    * On failure -- the username is taken -- the API will respond with HTTP code `400 BAD REQUEST` and the page will alert the user that this username is taken and prompt the user to `try again`.
        * If the user selects `try again` the page will refresh.

**Contact Scraper**
* Gist/TBD: the contacts will be sent in a `POST` request to `/api/v1/accounts/import/` and the API will automatically establish friendships based on shared contacts.
* On success, the server will respond with HTTP code `200 SUCCESS` and the application will redirect to the **Live Bets** page.

**Live Bets**
*  The application will send a `GET` request to `/api/v1/live/?loguser=<id>&auth=<pwhash>`
    *  On success, the API will respond with HTTP code `200 SUCCESS` and the data necessary to render the page.
* Once rendered, if the user selects a bet event they will be redirected to the **Bet Viewer** Page.
* Once rendered, the user may click the favorite icon on a bet event and a `POST` request will be sent to `/api/v1/likes/<postid>?loguser=<id>&auth=<pwhash>`
    * On success, the API will respond with HTTP code `200 SUCCESS` and the application will rerender the bet to reflect the change.
* Once rendered, the user may click `add a comment` and a comment box will appear. When the user has finished crafting a comment, they can hit submit and the comment will be sent via a `POST request to `/api/v1/comments/?betid=<id>`
    * On success, the API will respond with HTTP code `200 SUCCESS` and the application will rerender the bet to reflect the change.

***
***
