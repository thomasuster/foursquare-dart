#library('Foursquare API client');

#import('dart:html');
#import('dart:json');
#import('oauth2.dart');
#import('uri.dart');


class Foursquare {
  String _accessToken;
  _RequestFactory _requestFactory;
  String _clientId;

  Foursquare(String clientId, [String clientSecret]) {
    this._requestFactory = new _RequestFactory(clientId, clientSecret);
    this._clientId = clientId;
  }

  void login([VoidCallback successCallback]) {
    AuthRequest req = new AuthRequest('https://foursquare.com/oauth2/authenticate', _clientId);
    new Auth().login(req,
      successCallback: (String accessToken) {
        _requestFactory._accessToken = accessToken;

        if (successCallback != null) {
          successCallback();
        }
      },
      errorCallback: (AuthError e) {
        window.alert(e.error);
      });
  }

  _Users get users() => new _Users(_requestFactory);
  _Venues get venues() => new _Venues(_requestFactory);
}

abstract class _Endpoint {
  final String _endpoint;
  final _RequestFactory _requestFactory;
}

class _Users extends _Endpoint {
  _Users(_RequestFactory requestFactory) {
    this._endpoint = 'users';
    this._requestFactory = requestFactory;
  }

  _GetRequest leaderboard([Map<String, String> params]) {
    return _requestFactory.buildGetRequest('$_endpoint/leaderboard', params);
  }

  _PostRequest approve(String userId) {
    return _requestFactory.buildPostRequest('$_endpoint/$userId/approve');
  }
}

class _Venues extends _Endpoint {
  _Venues(_RequestFactory requestFactory) {
    this._endpoint = 'venues';
    this._requestFactory = requestFactory;
  }

  _GetRequest search(Map<String, String> params) {
    return _requestFactory.buildGetRequest('$_endpoint/search', params);
  }
}

class _RequestFactory {
  final String _API_ENDPOINT = 'https://api.foursquare.com/v2';
  final String _VERSION = 'v20120429';
  String _accessToken;

  String _clientId;
  String _clientSecret;

  _RequestFactory(String clientId, String clientSecret) {
    this._clientId = clientId;
    this._clientSecret = clientSecret;
  }

  _GetRequest buildGetRequest(String path, [Map<String, String> params]) {
    String paramsStr = _paramsStr(params);
    String url = '$_API_ENDPOINT/$path?$paramsStr';
    return new _GetRequest(url);
  }

  _PostRequest buildPostRequest(String path, [Map<String, String> params]) {
    String paramsStr = _paramsStr(params);
    String url = '$_API_ENDPOINT/$path';
    return new _PostRequest(url, params);
  }

  String _paramsStr(Map<String, String> params) {
    List<String> parts = new List.from(['v=$_VERSION']);
    if (_accessToken != null) {
      parts.add('oauth_token=$_accessToken');
    } else {
      // Userless access
      parts.addAll(['client_id=$_clientId', 'client_secret=$_clientSecret']);
    }
    if (params != null) {
      params.forEach((String key, String val) {
        String encodedValue = encodeURIComponent(val);
        parts.add('$key=$encodedValue');
      });
    }
    return Strings.join(parts, '&');
  }
}

typedef bool SuccessCallback(Object);
typedef bool FailureCallback(Object);

abstract class _Request {
  void _doExecute(String url, String method, [Map<String, String> params,
      SuccessCallback successCallback, FailureCallback failureCallback]) {
    XMLHttpRequest xhr = new XMLHttpRequest();
    xhr.open(method, url);
    xhr.on.loadEnd.add((Event e) {
      Object resp = JSON.parse(xhr.responseText);
      // TODO: Need to check if it's an error.
      if (successCallback != null) {
        successCallback(resp);
      }
    });
    xhr.send();
  }

  abstract void execute([SuccessCallback successCallback, FailureCallback failureCallback]);
}

class _GetRequest extends _Request {
  final String url;

  _GetRequest(this.url);

  void execute([SuccessCallback successCallback, FailureCallback failureCallback]) {
    _doExecute(this.url, 'GET', successCallback: successCallback, failureCallback: failureCallback);
  }
}

class _PostRequest extends _Request {
  final String url;
  final Map<String, String> params;

  _PostRequest(this.url, [this.params=null]);

  void execute([SuccessCallback successCallback, FailureCallback failureCallback]) {
    _doExecute(this.url, 'POST', params: params, successCallback: successCallback,
      failureCallback: failureCallback);
  }
}