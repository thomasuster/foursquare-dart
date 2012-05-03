class Tips {
  final String endpoint = 'tips';

  /*
   * General
   */

  Request get(String tipId, [Map<String, String> additional]) {
    return new Request('GET', '$endpoint/$tipId', additional);
  }

  Request add(String venueId, String text, [String url, String broadcast,
      Map<String, String> additional]) {
    Map<String, String> params = _combine({
      'venueId': venueId,
      'text': text,
      'url': url,
      'broadcast': broadcast,
    }, additional);
    return new Request('POST', '$endpoint/add', params);
  }

  Request search([String ll, String near, int limit, int offset, String filter,
      String query, Map<String, String> additional]) {
    Map<String, String> params = _combine({
      'll': ll,
      'near': near,
      'limit': limit.toString(),
      'offset': offset.toString(),
      'filter': filter,
      'query': query,
    }, additional);
    return new Request('GET', '$endpoint/search', params);
  }

  /*
   * Aspects
   */

  Request done(String tipId, [int limit, int offset,
      Map<String, String> additional]) {
    Map<String, String> params = _combine({
      'limit': limit.toString(),
      'offset': offset.toString(),
    }, additional);
    return new Request('GET', '$endpoint/$tipId/done', params);
  }

  Request listed(String tipId, [String edited,
      Map<String, String> additional]) {
    Map<String, String> params = _combine({
      'edited': edited,
    }, additional);
    return new Request('GET', '$endpoint/$tipId/listed', params);
  }

  /*
   * Actions
   */

  Request markdone(String tipId, [Map<String, String> additional]) {
    return new Request('POST', '$endpoint/$tipId/markdone',
        additional);
  }

  Request marktodo(String tipId, [Map<String, String> additional]) {
    return new Request('POST', '$endpoint/$tipId/marktodo',
        additional);
  }

  Request unmark(String tipId, [Map<String, String> additional]) {
    return new Request('POST', '$endpoint/$tipId/unmark', additional);
  }
}