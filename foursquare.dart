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
  _Checkins get checkins() => new _Checkins(_requestFactory);
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

  /*
   * General
   */

  _GetRequest get(String userId) {
    return _requestFactory.build('GET', '$_endpoint/$userId');
  }

  _GetRequest leaderboard([Map<String, String> params]) {
    return _requestFactory.build('GET', '$_endpoint/leaderboard', params);
  }

  _GetRequest requests() {
    return _requestFactory.build('GET', '$_endpoint/requests');
  }

  _GetRequest search([Map<String, String> params]) {
    return _requestFactory.build('GET', '$_endpoint', params);
  }

  /*
   * Aspects
   */

  _GetRequest badges([String userId='self']) {
    return _requestFactory.build('GET', '$_endpoint/$userId/badges');
  }

  _GetRequest checkins([String userId='self', Map<String, String> params]) {
    return _requestFactory.build('GET', '$_endpoint/$userId/checkins', params);
  }

  _GetRequest friends([String userId='self', Map<String, String> params]) {
    return _requestFactory.build('GET', '$_endpoint/$userId/friends', params);
  }

  _GetRequest lists([String userId='self', Map<String, String> params]) {
    return _requestFactory.build('GET', '$_endpoint/$userId/lists', params);
  }

  _GetRequest mayorships([String userId='self', Map<String, String> params]) {
    return _requestFactory.build('GET', '$_endpoint/$userId/mayorships', params);
  }

  _GetRequest photos([String userId='self', Map<String, String> params]) {
    return _requestFactory.build('GET', '$_endpoint/$userId/photos', params);
  }

  _GetRequest tips([String userId='self', Map<String, String> params]) {
    return _requestFactory.build('GET', '$_endpoint/$userId/tips', params);
  }

  _GetRequest todos([String userId='self', Map<String, String> params]) {
    return _requestFactory.build('GET', '$_endpoint/$userId/todos', params);
  }

  _GetRequest venuehistory([String userId='self', Map<String, String> params]) {
    return _requestFactory.build('GET', '$_endpoint/$userId/venuehistory', params);
  }

  /*
   * Actions
   */

  _PostRequest approve(String userId) {
    return _requestFactory.build('POST', '$_endpoint/$userId/approve');
  }

  _PostRequest deny(String userId) {
    return _requestFactory.build('POST', '$_endpoint/$userId/deny');
  }

  _PostRequest request(String userId) {
    return _requestFactory.build('POST', '$_endpoint/$userId/request');
  }

  _PostRequest setpings(String userId) {
    return _requestFactory.build('POST', '$_endpoint/$userId/setpings');
  }

  _PostRequest unfriend(String userId) {
    return _requestFactory.build('POST', '$_endpoint/$userId/unfriend');
  }

  _PostRequest update([Map<String, String> params]) {
    return _requestFactory.build('POST', '$_endpoint/self/update', params);
  }
}

class _Venues extends _Endpoint {
  _Venues(_RequestFactory requestFactory) {
    this._endpoint = 'venues';
    this._requestFactory = requestFactory;
  }

  /*
   * General
   */

  _GetRequest get(String venueId) {
    return _requestFactory.build('GET', '$_endpoint/$venueId');
  }

  _PostRequest add(Map<String, String> params) {
    return _requestFactory.build('POST', '$_endpoint/add', params);
  }

  _GetRequest categories() {
    return _requestFactory.build('GET', '$_endpoint/categories');
  }

  _GetRequest explore(Map<String, String> params) {
    return _requestFactory.build('GET', '$_endpoint/explore', params);
  }

  _GetRequest managed() {
    return _requestFactory.build('GET', '$_endpoint/managed');
  }

  _GetRequest search(Map<String, String> params) {
    return _requestFactory.build('GET', '$_endpoint/search', params);
  }

  _GetRequest suggestcompletion(Map<String, String> params) {
    return _requestFactory.build('GET', '$_endpoint/suggestcompletion', params);
  }

  _GetRequest timeseries(Map<String, String> params) {
    return _requestFactory.build('GET', '$_endpoint/timeseries', params);
  }

  _GetRequest trending(Map<String, String> params) {
    return _requestFactory.build('GET', '$_endpoint/trending', params);
  }

  /*
   * Aspects
   */

  _GetRequest events(String venueId) {
    return _requestFactory.build('GET', '$_endpoint/$venueId/events');
  }

  _GetRequest herenow(String venueId, [Map<String, String> params]) {
    return _requestFactory.build('GET', '$_endpoint/$venueId/herenow', params);
  }

  _GetRequest links(String venueId) {
    return _requestFactory.build('GET', '$_endpoint/$venueId/links');
  }

  _GetRequest listed(String venueId, [Map<String, String> params]) {
    return _requestFactory.build('GET', '$_endpoint/$venueId/listed', params);
  }

  _GetRequest menu(String venueId, [Map<String, String> params]) {
    return _requestFactory.build('GET', '$_endpoint/$venueId/menu', params);
  }

  _GetRequest photos(String venueId, Map<String, String> params) {
    return _requestFactory.build('GET', '$_endpoint/$venueId/photos', params);
  }

  _GetRequest similar(String venueId) {
    return _requestFactory.build('GET', '$_endpoint/$venueId/similar');
  }

  _GetRequest stats(String venueId, [Map<String, String> params]) {
    return _requestFactory.build('GET', '$_endpoint/$venueId/stats', params);
  }

  _GetRequest tips(String venueId, [Map<String, String> params]) {
    return _requestFactory.build('GET', '$_endpoint/$venueId/tips', params);
  }

  /*
   * Actions
   */

  _PostRequest flag(String venueId, Map<String, String> params) {
    return _requestFactory.build('POST', '$_endpoint/$venueId/flag', params);
  }

  _PostRequest edit(String venueId, Map<String, String> params) {
    return _requestFactory.build('POST', '$_endpoint/$venueId/edit', params);
  }

  _PostRequest proposeedit(String venueId, Map<String, String> params) {
    return _requestFactory.build('POST', '$_endpoint/$venueId/proposeedit', params);
  }

  _PostRequest marktodo(String venueId, Map<String, String> params) {
    return _requestFactory.build('POST', '$_endpoint/$venueId/marktodo', params);
  }
}

class _Checkins extends _Endpoint {
  _Checkins(_RequestFactory requestFactory) {
    this._endpoint = 'checkins';
    this._requestFactory = requestFactory;
  }

  /*
   * General
   */

  _GetRequest get(String checkinId) {
    return _requestFactory.build('GET', '$_endpoint/$checkinId');
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

  _Request build(String method, String path, [Map<String, String> params]) {
    String paramsStr = _paramsStr(params);
    String url = '$_API_ENDPOINT/$path?$paramsStr';
    switch (method) {
      case 'GET':
        return new _GetRequest(url);
      case 'POST':
        return new _PostRequest(url);
    }
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