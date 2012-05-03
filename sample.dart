#import('dart:html');
#import('foursquare.dart');

String _CLIENT_ID = 'T0JY25PVRECQGBURYCFBC4NHWOQDFFFHA11YRHTQEGF5E00I';
String _REDIRECT_URI =
    'http://foursquare-dart.googlecode.com/git/oauthWindow.html';

main() {
  Foursquare fsq = new Foursquare(_CLIENT_ID);

  Element e = document.query('#click');
  e.on.click.add((_) {
    fsq.login(_REDIRECT_URI).then((__) {
      e.remove();
      fsq.users.get().execute().then((userResp) {
        window.alert('Hello ${userResp["response"]["user"]["firstName"]}');

        fsq.requestFactory.build('GET', 'updates/notifications').execute()
            .then((notificationsResp) {
              window.alert('Notifications: ${notificationsResp["response"]["notifications"]["items"].length}');
            });
      });
    });
  });
}