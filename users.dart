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
    return _requestFactory.build('GET', '$_endpoint/$userId/mayorships',
        params);
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
    return _requestFactory.build('GET', '$_endpoint/$userId/venuehistory',
        params);
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
