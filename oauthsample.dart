#import('dart:html');
#import('oauth2.dart');

String REDIRECT_URI =
    'http://foursquare-dart.googlecode.com/git/oauthWindow.html';

main() {
  document.query('#google').on.click.add((_) {
    String authUrl = 'https://accounts.google.com/o/oauth2/auth';
    String clientId = '363487865191.apps.googleusercontent.com';
    String emailScope = 'https://www.googleapis.com/auth/userinfo.email';
    login(authUrl, clientId, REDIRECT_URI, scopes: [emailScope])
        .then((String accessToken) {
          window.alert('Access token: $accessToken');
        });
  });

  document.query('#facebook').on.click.add((_) {
    String authUrl = 'https://www.facebook.com/dialog/oauth';
    String clientId = '195156450604875';
    String emailScope = 'email';
    login(authUrl, clientId, REDIRECT_URI, scopes: [emailScope],
        scopeDelimiter: ',')
        .then((String accessToken) {
          window.alert('Access token: $accessToken');
        });
  });

  document.query('#foursquare').on.click.add((_) {
    String authUrl = 'https://foursquare.com/oauth2/authenticate';
    // TODO: This will need to change if the redirect URL does.
    String clientId = 'T0JY25PVRECQGBURYCFBC4NHWOQDFFFHA11YRHTQEGF5E00I';
    login(authUrl, clientId, REDIRECT_URI)
        .then((String accessToken) {
          window.alert('Access token: $accessToken');
        });
  });
}