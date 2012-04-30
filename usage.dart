#import('foursquare.dart');

main() {
  Foursquare fsq = new Foursquare('CLIENT_ID', 'CLIENT_SECRET');

  // Demonstrates userless access
  fsq.venues.search(query: "Bob's Biscuits",
    additional: {
      'foo': 'bar'
    }).execute(successCallback: (Map resp) {

  });

  fsq.accessToken = 'foobarbaz';

  // Demonstrates GET request
  fsq.users.search(twitter: ['aplusk'],
    additional: {
      'foo': 'bar'
    }).execute(successCallback: (Map resp) {
  });

  // Demonstrates POST request and required param
  fsq.users.approve('abcdefg').execute(successCallback: (Map resp) {

  });

  // Demonstrates arbitrary API method invocation, to support methods not yet
  // officially included in the library.
  fsq.requestFactory.build('GET', 'updates/notifications', {
    'limit': 100
  }).execute(successCallback: (Map resp) {

  });

  // Demonstrates top-level "get" method
  /* Not functional
  _Venues v = fsq.venues('venue-id').execute(successCallback: (Map resp) {

  });
  */
}