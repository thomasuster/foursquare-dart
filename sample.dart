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
      fsq.users.get().execute().then((r1) {
        window.alert('Hello ${r1["response"]["user"]["firstName"]}');

        // Example of building an arbitrary request not covered by a
        // pre-defined utility methods.
        new Request('GET', 'updates/notifications').execute().then((Map r2) {
          window.console.log(r2['response']['notifications']['count']);
        });

        // Example of making a multi request
        fsq.multi([fsq.users.get(), fsq.users.get('32'), fsq.users.get('33')])
            .execute().then((Map r3) {
              window.console.log(r3['response']['responses'].length);
            });
      });
    });
  });
}