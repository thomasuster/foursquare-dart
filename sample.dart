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

      // Example of a standard request, for the current user's information.
      fsq.users.get().execute().then((r1) {
        log('Hello ${r1["response"]["user"]["firstName"]}');
      });

      // Example of building an arbitrary request not covered by a pre-defined
      // utility methods.
      new Request('GET', 'updates/notifications').execute().then((r2) {
        log('Notifications: ${r2["response"]["notifications"]["count"]}');
      });

      // Example of making a multi request consisting of three batched requests.
      fsq.multi([fsq.users.get(), fsq.users.get('32'), fsq.users.get('33')])
          .execute().then((r3) {
            log('Multi responses: ${r3["response"]["responses"].length}');
          });
    });
  });
}

void log(String s) {
  Element e = document.$dom_createElement('pre');
  e.text = s.toString();
  document.body.elements.add(e);
}