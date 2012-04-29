#import('foursquare.dart');

main() {
  Foursquare fsq = new Foursquare('CLIENT_ID', 'CLIENT_SECRET');

  // Demonstrates userless access
  fsq.venues.search({
    'foo': 'bar'
  }).execute(successCallback: (Object o) {

  });

  fsq.login(successCallback: () {
    // Demonstrates GET request
    fsq.users.leaderboard({
      'foo': 'bar'
    }).execute(successCallback: (Object o) {

    });

    // Demonstrates POST request and required param
    fsq.users.approve('abcdefg').execute(successCallback: (Object o) {

    });
  });
}