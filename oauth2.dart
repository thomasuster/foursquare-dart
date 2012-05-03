#library('OAuth 2.0 client library');

#import('dart:html');
#import('dart:json');
#import('uri.dart');

class AuthError implements Exception {
  String error;
  String errorDescription;
  String errorUri;

  AuthError(this.error, this.errorDescription, this.errorUri);
}

AuthRequest _lastRequest;
Completer<String> _lastCompleter;
Window _authWindow;

bool addedCallback = false;

Future<String> login(AuthRequest req, [Function successCallback,
    Function errorCallback,
    int windowHeight=600, int windowWidth=800]) {

  if (!addedCallback) {
    addedCallback = true;
    window.on.message.add((MessageEvent e) {
      finish(e.data);
    }, false);
  }
  String tokenStr = window.localStorage.$dom_getItem(req.asString());
  _TokenInfo info = tokenStr == null ? null :
      new _TokenInfo.fromString(tokenStr);

  if (info == null || info._expires == null || _expiringSoon(info)) {
    if (_authWindow != null && !_authWindow.closed && errorCallback != null) {
      errorCallback(new AuthError('Authentication in progress', null, null));
    } else {
      _lastRequest = req;
      _lastCompleter = new Completer<String>();
      window = window.open(req.toUrl(), 'authWindow',
          'width=$windowWidth,height=$windowHeight');
    }
    return _lastCompleter.future;
  } else {
    return new Future.immediate(info._accessToken);
  }
}

bool _expiringSoon(_TokenInfo info) {
  if (info._expires == null || info._expires == 'null') {
    return false;
  } else {
    window.console.log(info._expires);
    window.console.log(info._expires == 'null');
    int expires = Math.parseInt(info._expires == null ? '0' : info._expires);
    int tenMinutesFromNow = new Date.now().milliseconds + (10 * 60 * 1000);
    return expires < tenMinutesFromNow;
  }
}

void finish(String hash) {
  // Close the pop-up once the hash is received.
  if (_authWindow != null && !_authWindow.closed) {
    _authWindow.close();
    _authWindow = null;
  }

  // Parse the hash into its values.
  Map<String, String> values = {};
  int idx = 1;
  while (idx < hash.length - 1) {
    // Grab the next key (between start and '=')
    int nextEq = hash.indexOf('=', idx);
    if (nextEq < 0) {
      break;
    }
    String key = hash.substring(idx, nextEq);

    // Grab the next value (between '=' and '&')
    int nextAmp = hash.indexOf('&', nextEq);
    nextAmp = nextAmp < 0 ? hash.length : nextAmp;
    String val = hash.substring(nextEq + 1, nextAmp);

    // Start looking from here from now on.
    idx = nextAmp + 1;

    // Store values to be used later
    values[key] = val;
  }

  // Call the appropriate callback with data.
  if (values['error'] != null && _lastCompleter != null) {
    _lastCompleter.completeException(new AuthError(values['error'],
        values['error_description'], values['error_uri']));
  } else {
    // Store the token info for later retrieval.
    _TokenInfo info = new _TokenInfo();
    info._accessToken = values['access_token'];
    info._expires = values['expires'];
    window.localStorage.$dom_setItem(_lastRequest.asString(), info.asString());

    _lastCompleter.complete(values['access_token']);
  }
}

class _TokenInfo {
  String _accessToken;
  String _expires;

  _TokenInfo() {
  }

  _TokenInfo.fromString(String s) {
    List<String> parts = s.split('=====');
    _accessToken = parts[0];
    _expires = parts.length > 1 ? parts[1] : null;
  }

  String asString() {
    return '$_accessToken=====$_expires';
  }
}

class AuthRequest {
  final String _authUrl;
  String clientId;
  List<String> scopes;
  String scopeDelimiter;
  String redirectUri;

  AuthRequest(this._authUrl, this.clientId, this.redirectUri, [this.scopes=null,
      this.scopeDelimiter=' ']);

  String toUrl() {
    String encodedClientId = encodeURIComponent(clientId);
    String encodedRedirectUri = encodeURIComponent(redirectUri);
    String scopesStr = ''; // TODO scopes == null ? '' :
        //Strings.join(scopes, scopeDelimiter);
    return '$_authUrl?client_id=$encodedClientId&redirect_uri='
        + '$encodedRedirectUri&response_type=token&scopes=$scopesStr';
  }

  String asString() {
    return '$clientId=====$scopes';
  }
}

/** Called by popup to communicate the hash back to the parent window. */
void initForPopup() {
  window.opener.postMessage(window.location.hash, '*');
}