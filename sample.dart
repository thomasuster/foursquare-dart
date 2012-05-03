#import('dart:html');
#import('foursquare.dart');

String CLIENT_ID = 'T0JY25PVRECQGBURYCFBC4NHWOQDFFFHA11YRHTQEGF5E00I';
String REDIRECT_URI =
    'http://foursquare-dart.googlecode.com/git/oauthWindow.html';

main() {
  Foursquare fsq = new Foursquare(CLIENT_ID);

  Element e = document.query('#click');
  e.on.click.add((_) {
    fsq.login(REDIRECT_URI).then((__) {
      e.remove();
      fsq.users.get().execute().then((userResp) {
        window.alert('Hello ${userResp["response"]["user"]["firstName"]}');

        // Example of building an arbitrary request not covered by a
        // pre-defined utility methods.
        new Request('GET', 'updates/notifications').execute()
            .then((notificationsResp) {
              window.alert('Notifications: ${notificationsResp["response"]["notifications"]["items"].length}');
            });
      });
    });
  });
}