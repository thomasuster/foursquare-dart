class Users {
  final String endpoint = 'users';

  /*
   * General
   */

  Request get([String userId='self', Map<String, String> additional]) {
    return new Request('GET', '$endpoint/$userId', additional);
  }

  Request leaderboard([int neighbors, Map<String, String> additional]) {
    Map params = _combine({
      'neighbors': neighbors,
    }, additional);
    return new Request('GET', '$endpoint/leaderboard', params);
  }

  Request requests([Map<String, String> additional]) {
    return new Request('GET', '$endpoint/requests', additional);
  }

  Request search([List<String> phone, List<String> email,
      List<String> twitter, String twitterSource, List<String> fbid,
      String name, Map<String, String> additional]) {
    Map params = _combine({
      'phone': Strings.join(phone, ','),
      'email': Strings.join(email, ','),
      'twitter': Strings.join(twitter, ','),
      'twitterSource': twitterSource,
      'fbid': Strings.join(fbid, ','),
      'name': name,
    }, additional);
    return new Request('GET', '$endpoint', params);
  }

  /*
   * Aspects
   */

  Request badges([String userId='self', Map<String, String> additional]) {
    return new Request('GET', '$endpoint/$userId/badges', additional);
  }

  Request checkins([String userId='self', int limit, int offset,
      int afterTimestamp, int beforeTimestamp,
      Map<String, String> additional]) {
    Map params = _combine({
      'limit': limit,
      'offset': offset,
      'afterTimestamp': afterTimestamp,
      'beforeTimestamp': beforeTimestamp,
    }, additional);
    return new Request('GET', '$endpoint/$userId/checkins', params);
  }

  Request friends([String userId='self', int limit, int offset,
      Map<String, String> additional]) {
    Map params = _combine({
      'limit': limit,
      'offset': offset,
    }, additional);
    return new Request('GET', '$endpoint/$userId/friends', params);
  }

  Request lists([String userId='self', String group, String ll,
      Map<String, String> additional]) {
    Map params = _combine({
      'group': group,
      'll': ll,
    }, additional);
    return new Request('GET', '$endpoint/$userId/lists', params);
  }

  Request mayorships([String userId='self',
      Map<String, String> additional]) {
    return new Request('GET', '$endpoint/$userId/mayorships',
        additional);
  }

  Request photos([String userId='self', int limit, int offset,
      Map<String, String> additional]) {
    Map params = _combine({
      'limit': limit,
      'offset': offset,
    }, additional);
    return new Request('GET', '$endpoint/$userId/photos', params);
  }

  Request tips([String userId='self', String sort, String ll, int limit,
      int offset, Map<String, String> additional]) {
    Map params = _combine({
      'sort': sort,
      'll': ll,
      'limit': limit,
      'offset': offset,
    }, additional);
    return new Request('GET', '$endpoint/$userId/tips', params);
  }

  Request todos([String userId='self', String sort, String ll,
      Map<String, String> additional]) {
    Map params = _combine({
      'sort': sort,
      'll': ll,
    }, additional);
    return new Request('GET', '$endpoint/$userId/todos', params);
  }

  Request venuehistory([String userId='self', int beforeTimestamp,
      int afterTimestamp, String categoryId, Map<String, String> additional]) {
    Map params = _combine({
      'beforeTimestamp': beforeTimestamp,
      'afterTimestamp': afterTimestamp,
      'categoryId': categoryId,
    }, additional);
    return new Request('GET', '$endpoint/$userId/venuehistory', params);
  }

  /*
   * Actions
   */

  Request approve(String userId, [Map<String, String> additional]) {
    return new Request('POST', '$endpoint/$userId/approve', additional);
  }

  Request deny(String userId, [Map<String, String> additional]) {
    return new Request('POST', '$endpoint/$userId/deny', additional);
  }

  Request request(String userId, [Map<String, String> additional]) {
    return new Request('POST', '$endpoint/$userId/request', additional);
  }

  Request setpings(String userId, bool value,
      [Map<String, String> additional]) {
    Map params = _combine({
      'value': value,
    }, additional);
    return new Request('POST', '$endpoint/$userId/setpings', params);
  }

  Request unfriend(String userId, [Map<String, String> additional]) {
    return new Request('POST', '$endpoint/$userId/unfriend', additional);
  }

  // TODO(jason): Support file upload for photo parameter.
  Request update([Map<String, String> additional]) {
    return new Request('POST', '$endpoint/self/update', additional);
  }
}
