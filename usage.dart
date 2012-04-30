#import('foursquare.dart');

main() {
  Foursquare fsq = new Foursquare('CLIENT_ID', 'CLIENT_SECRET');

  // Demonstrates userless access
  fsq.venues.search({
    'foo': 'bar'
  }).execute(successCallback: (Object o) {

  });

  fsq.accessToken = 'foobarbaz';

  // Demonstrates GET request
  fsq.users.leaderboard(neighbors: 123,
    additional: {
      'foo': 'bar'
    }).execute(successCallback: (Object o) {

  });

  // Demonstrates POST request and required param
  fsq.users.approve('abcdefg').execute(successCallback: (Object o) {

  });

  // Demonstrates top-level "get" method
  /* Not functional
  _Venues v = fsq.venues('venue-id').execute(successCallback: (Object o) {

  });
  */
}