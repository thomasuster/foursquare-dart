#library('OAuth 2.0 client library');

#import('dart:dom');
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
  AuthCallback _lastCallback;
  AuthErrorCallback _lastErrorCallback;
  Window _authWindow;

  void login(AuthRequest req, [AuthCallback successCallback, AuthErrorCallback errorCallback,
      int windowHeight=600, int windowWidth=800]) {
    this._lastCallback = successCallback;
    this._lastErrorCallback = errorCallback;

    // TODO: Check if there is a token already stored locally.

    if (_authWindow != null && !_authWindow.closed && errorCallback != null) {
      errorCallback(new AuthError('Authentication in progress', null, null));
    } else {
      window = window.open(req.toUrl(), 'authWindow', 'width=$windowWidth,height=$windowHeight');
    }
  }

  void finish(String hash) {
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
      _lastCallback(values['access_token']);
    }
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
}
