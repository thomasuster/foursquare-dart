class _Users extends _Endpoint {
  _Users(_RequestFactory requestFactory) {
    this._endpoint = 'users';
    this._requestFactory = requestFactory;
  }

  /*
   * General
   */

  _GetRequest get(String userId, [Map<String, String> additional]) {
    return _requestFactory.build('GET', '$_endpoint/$userId', additional);
  }

  _GetRequest leaderboard([int neighbors, Map<String, String> additional]) {
    Map<String, String> params = _combine({
      'neighbors': neighbors.toString(),
    }, additional);
    return _requestFactory.build('GET', '$_endpoint/leaderboard', params);
  }

  _GetRequest requests([Map<String, String> additional]) {
    return _requestFactory.build('GET', '$_endpoint/requests', additional);
  }

  _GetRequest search([List<String> phone, List<String> email,
      List<String> twitter, String twitterSource, List<String> fbid,
      String name, Map<String, String> additional]) {
    Map<String, String> params = _combine({
      'phone': Strings.join(phone, ','),
      'email': Strings.join(email, ','),
      'twitter': Strings.join(twitter, ','),
      'twitterSource': twitterSource,
      'fbid': Strings.join(fbid, ','),
      'name': name,
    }, additional);
    return _requestFactory.build('GET', '$_endpoint', params);
  }

  /*
   * Aspects
   */

  _GetRequest badges([String userId='self', Map<String, String> additional]) {
    return _requestFactory.build('GET', '$_endpoint/$userId/badges',
        additional);
  }

  _GetRequest checkins([String userId='self', int limit, int offset,
      int afterTimestamp, int beforeTimestamp,
      Map<String, String> additional]) {
    Map<String, String> params = _combine({
      'limit': limit.toString(),
      'offset': offset.toString(),
      'afterTimestamp': afterTimestamp.toString(),
      'beforeTimestamp': beforeTimestamp.toString(),
    }, additional);
    return _requestFactory.build('GET', '$_endpoint/$userId/checkins', params);
  }

  _GetRequest friends([String userId='self', int limit, int offset,
      Map<String, String> additional]) {
    Map<String, String> params = _combine({
      'limit': limit.toString(),
      'offset': offset.toString(),
    }, additional);
    return _requestFactory.build('GET', '$_endpoint/$userId/friends', params);
  }

  _GetRequest lists([String userId='self', String group, String ll,
      Map<String, String> additional]) {
    Map<String, String> params = _combine({
      'group': group,
      'll': ll,
    }, additional);
    return _requestFactory.build('GET', '$_endpoint/$userId/lists', params);
  }

  _GetRequest mayorships([String userId='self',
      Map<String, String> additional]) {
    return _requestFactory.build('GET', '$_endpoint/$userId/mayorships',
        additional);
  }

  _GetRequest photos([String userId='self', int limit, int offset,
      Map<String, String> additional]) {
    Map<String, String> params = _combine({
      'limit': limit.toString(),
      'offset': offset.toString(),
    }, additional);
    return _requestFactory.build('GET', '$_endpoint/$userId/photos', params);
  }

  _GetRequest tips([String userId='self', String sort, String ll, int limit,
      int offset, Map<String, String> additional]) {
    Map<String, String> params = _combine({
      'sort': sort,
      'll': ll,
      'limit': limit.toString(),
      'offset': offset.toString(),
    }, additional);
    return _requestFactory.build('GET', '$_endpoint/$userId/tips', params);
  }

  _GetRequest todos([String userId='self', String sort, String ll,
      Map<String, String> additional]) {
    Map<String, String> params = _combine({
      'sort': sort,
      'll': ll,
    }, additional);
    return _requestFactory.build('GET', '$_endpoint/$userId/todos', params);
  }

  _GetRequest venuehistory([String userId='self', int beforeTimestamp,
      int afterTimestamp, String categoryId, Map<String, String> additional]) {
    Map<String, String> params = _combine({
      'beforeTimestamp': beforeTimestamp.toString(),
      'afterTimestamp': afterTimestamp.toString(),
      'categoryId': categoryId,
    }, additional);
    return _requestFactory.build('GET', '$_endpoint/$userId/venuehistory',
        params);
  }

  /*
   * Actions
   */

  _PostRequest approve(String userId, [Map<String, String> additional]) {
    return _requestFactory.build('POST', '$_endpoint/$userId/approve',
        additional);
  }

  _PostRequest deny(String userId, [Map<String, String> additional]) {
    return _requestFactory.build('POST', '$_endpoint/$userId/deny', additional);
  }

  _PostRequest request(String userId, [Map<String, String> additional]) {
    return _requestFactory.build('POST', '$_endpoint/$userId/request',
        additional);
  }

  _PostRequest setpings(String userId, bool value,
      [Map<String, String> additional]) {
    Map<String, String> params = _combine({
      'value': value.toString(),
    }, additional);
    return _requestFactory.build('POST', '$_endpoint/$userId/setpings', params);
  }

  _PostRequest unfriend(String userId, [Map<String, String> additional]) {
    return _requestFactory.build('POST', '$_endpoint/$userId/unfriend',
        additional);
  }

  // TODO(jason): Support file upload for photo parameter.
  _PostRequest update([Map<String, String> additional]) {
    return _requestFactory.build('POST', '$_endpoint/self/update', additional);
  }
}
