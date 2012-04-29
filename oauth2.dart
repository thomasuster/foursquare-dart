#library('OAuth 2.0 client library');

#import('dart:dom');
#import('dart:json');
#import('uri.dart');

typedef bool AuthCallback(String);
typedef bool AuthErrorCallback(AuthError);

class AuthError {
  String error;
  String errorDescription;
  String errorUri;

  AuthError(this.error, this.errorDescription, this.errorUri);
}

class Auth {
  AuthRequest _lastRequest;
  AuthCallback _lastCallback;
  AuthErrorCallback _lastErrorCallback;
  Window _authWindow;

  void login(AuthRequest req, [AuthCallback successCallback, AuthErrorCallback errorCallback,
      int windowHeight=600, int windowWidth=800]) {
    this._lastRequest = req;
    this._lastCallback = successCallback;
    this._lastErrorCallback = errorCallback;

    // TODO: Check if there is a token already stored locally.
    String tokenStr = window.localStorage.getItem(req.asString());
    TokenInfo info = tokenStr == null ? null : new TokenInfo.fromString(tokenStr);

    if (info == null || info._expires == null || _expiringSoon(info)) {
      if (_authWindow != null && !_authWindow.closed && errorCallback != null) {
        errorCallback(new AuthError('Authentication in progress', null, null));
      } else {
        window = window.open(req.toUrl(), 'authWindow', 'width=$windowWidth,height=$windowHeight');
      }
    } else {
      successCallback(info._accessToken);
    }
  }

  bool _expiringSoon(TokenInfo info) {
    int expires = Math.parseInt(info._expires);
    int tenMinutesFromNow = new Date.now().milliseconds + (10 * 60 * 1000);
    return expires < tenMinutesFromNow;
  }

  void finish(String hash) {
    TokenInfo info = new TokenInfo();

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

    if (values['error'] != null && _lastErrorCallback != null) {
      _lastErrorCallback(new AuthError(values['error'], values['error_description'], values['error_uri']));
    } else if (_lastCallback != null) {

      // Store the token info.
      info._accessToken = values['access_token'];
      info._expires = values['expires'];
      window.localStorage.setItem(_lastRequest.asString, info.asString());

      _lastCallback(values['access_token']);
    }
  }
}

class TokenInfo {
  String _accessToken;
  String _expires;

  TokenInfo() {
  }

  TokenInfo.fromString(String s) {
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
  final String _clientId;
  final List<String> _scopes;
  final String _scopeDelimiter;
  final String _redirectUri;

  const AuthRequest(this._authUrl, this._clientId, [this._scopes=null, this._scopeDelimiter='',
      this._redirectUri='']);

  String toUrl() {
    String encodedClientId = encodeURIComponent(_clientId);
    String encodedRedirectUri = encodeURIComponent(_redirectUri);
    String scopesStr = _scopes == null ? '' : Strings.join(_scopes, _scopeDelimiter);
    return '$_authUrl?client_id=$encodedClientId&redirect_uri=$encodedRedirectUri&type=token&scopes=$scopesStr';
  }

  String asString() {
    return '$_clientId=====$_scopes';
  }
}