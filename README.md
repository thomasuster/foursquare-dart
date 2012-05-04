Foursquare API client library for the Dart language
===============

Sample usage:

0.) Import the library

```
#import('foursquare.dart');
```

1.) Instantiate a Foursquare object:

```
Foursquare fsq = new Foursquare(YOUR_APP_CLIENT_ID);
```

2.) (Optional) Authenticate with OAuth 2.0:

```
fsq.login(YOUR_REDIRECT_URI).then((_) {
  // The user has granted access to your application.
  // Requests made inside this Function will be made as that user.
});
```

3.) Make a request using a helper method:

```
fsq.users.search(email: ['bob@foo.com', 'alice@foo.com'],
    twitter: ['@bob', @alice']).execute().then((resp) {
  // resp is a JSON object of the API response.
});
```

OR

Make a request by constructing one manually:

```
Request r = new Request('GET', 'checkins/recent', { limit: 10 });
r.execute().then((resp) {
  // resp is a JSON object of the API response
});
```

4.) Make a multi request by passing multiple `Requests` to `fsq.multi()`:

```
fsq.multi([fsq.users.get('2068'),
           fsq.venues.search(ll: '40.7013,-73.7074'),
           fsq.checkins.recent(limit: 10)])
    .execute().then((resp) {
      // resp is a JSON object of the API response
      // in this case, resp['response']['responses'] will be a List of
      // responses, in the order they were provided
    });

```

[Sample Application](http://foursquare-dart.googlecode.com/git/sample.html)
====================


TODOs:
======

- Add helper classes for the rest of the endpoints
  - Make a decision about its usefulness and design
- Split the OAuth 2.0 library (and maybe the HTTP helpers?) into a separate project
  - Describe how OAuth works, how to set it up