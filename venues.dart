class Venues{
  final String endpoint = 'venues';
  final RequestFactory _requestFactory;

  Venues(this._requestFactory);

  /*
   * General
   */

  Request get(String venueId, [Map<String, String> additional]) {
    return _requestFactory.build('GET', '$endpoint/$venueId', additional);
  }

  Request add([String address, String crossStreet, String city,
      String state, String zip, String phone, String twitter, String ll,
      String primaryCategoryId, String description, String url,
      bool ignoreDuplicates, String ignoreDuplicatesKey,
      Map<String, String> additional]) {
    Map<String, String> params = _combine({
      'address': address,
      'crossStreet': crossStreet,
      'city': city,
      'state': state,
      'zip': zip,
      'phone': phone,
      'twitter': twitter,
      'll': ll,
      'primaryCategoryId': primaryCategoryId,
      'description': description,
      'url': url,
      'ignoreDuplicates': ignoreDuplicates.toString(),
      'ignoreDuplicatesKey': ignoreDuplicatesKey,
    }, additional);
    return _requestFactory.build('POST', '$endpoint/add', params);
  }

  Request categories([Map<String, String> additional]) {
    return _requestFactory.build('GET', '$endpoint/categories', additional);
  }

  Request explore([String ll, String near, num llAcc, int alt, num altAcc,
      int radius, String section, String query, int limit, String intent,
      String novelty, Map<String, String> additional]) {
    Map<String, String> params = _combine({
      'll': ll,
      'near': near,
      'llAcc': llAcc.toString(),
      'alt': alt.toString(),
      'altAcc': alt.toString(),
      'radius': radius.toString(),
      'section': section,
      'query': query,
      'limit': limit.toString(),
      'intent': intent,
      'novelty': novelty,
    }, additional);
    return _requestFactory.build('GET', '$endpoint/explore', params);
  }

  Request managed([Map<String, String> additional]) {
    return _requestFactory.build('GET', '$endpoint/managed', additional);
  }

  Request search([String ll, String near, num llAcc, int alt, num altAcc,
      String query, int limit, String intent, int radius, String sw, String ne,
      String categoryId, String url, String providerId, int linkedId,
      Map<String, String> additional]) {
    Map<String, String> params = _combine({
      'll': ll,
      'near': near,
      'llAcc': llAcc.toString(),
      'alt': alt.toString(),
      'altAcc': altAcc.toString(),
      'query': query,
      'limit': limit.toString(),
      'intent': intent,
      'radius': radius.toString(),
      'sw': sw,
      'ne': ne,
      'categoryId': categoryId,
      'url': url,
      'providerId': providerId,
      'linkedId': linkedId.toString(),
    }, additional);
    return _requestFactory.build('GET', '$endpoint/search', params);
  }

  Request suggestcompletion(String ll, [num llAcc, int alt, num altAcc,
      String query, int limit, Map<String, String> additional]) {
    Map<String, String> params = _combine({
      'll': ll,
      'llAcc': llAcc.toString(),
      'alt': alt.toString(),
      'altAcc': altAcc.toString(),
      'query': query,
      'limit': limit.toString(),
    }, additional);
    return _requestFactory.build('GET', '$endpoint/suggestcompletion', params);
  }

  Request timeseries(String venueId, [int startAt, int endAt,
      Map<String, String> additional]) {
    Map<String, String> params = _combine({
      'venueId': venueId,
      'startAt': startAt.toString(),
      'endAt': endAt.toString(),
    }, additional);
    return _requestFactory.build('GET', '$endpoint/timeseries', params);
  }

  Request trending(String ll, [int limit, int radius,
      Map<String, String> additional]) {
    Map<String, String> params = _combine({
      'll': ll,
      'limit': limit.toString(),
      'radius': radius.toString(),
    }, additional);
    return _requestFactory.build('GET', '$endpoint/trending', params);
  }

  /*
   * Aspects
   */

  Request events(String venueId, [Map<String, String> additional]) {
    return _requestFactory.build('GET', '$endpoint/$venueId/events',
        additional);
  }

  Request herenow(String venueId, [int limit, int offset,
      int afterTimestamp, Map<String, String> additional]) {
    Map<String, String> params = _combine({
      'limit': limit.toString(),
      'offset': offset.toString(),
      'afterTimestamp': afterTimestamp.toString(),
    }, additional);
    return _requestFactory.build('GET', '$endpoint/$venueId/herenow', params);
  }

  Request links(String venueId, [Map<String, String> additional]) {
    return _requestFactory.build('GET', '$endpoint/$venueId/links',
        additional);
  }

  Request listed(String venueId, [String group, int limit, int offset,
      Map<String, String> additional]) {
    Map<String, String> params = _combine({
      'group': group,
      'limit': limit.toString(),
      'offset': offset.toString(),
    }, additional);
    return _requestFactory.build('GET', '$endpoint/$venueId/listed', params);
  }

  Request menu(String venueId, [Map<String, String> additional]) {
    return _requestFactory.build('GET', '$endpoint/$venueId/menu', additional);
  }

  Request photos(String venueId, String group, [int limit, int offset,
      Map<String, String> additional]) {
    Map<String, String> params = _combine({
      'group': group,
      'limit': limit.toString(),
      'offset': offset.toString(),
    }, additional);
    return _requestFactory.build('GET', '$endpoint/$venueId/photos', params);
  }

  Request similar(String venueId, [Map<String, String> additional]) {
    return _requestFactory.build('GET', '$endpoint/$venueId/similar',
        additional);
  }

  Request stats(String venueId, [int startAt, int endAt,
      Map<String, String> additional]) {
    Map<String, String> params = _combine({
      'startAt': startAt.toString(),
      'endAt': endAt.toString(),
    }, additional);
    return _requestFactory.build('GET', '$endpoint/$venueId/stats', params);
  }

  Request tips(String venueId, [String sort, int limit, int offset,
       Map<String, String> additional]) {
    Map<String, String> params = _combine({
      'sort': sort,
      'limit': limit.toString(),
      'offset': offset.toString(),
    }, additional);
    return _requestFactory.build('GET', '$endpoint/$venueId/tips', params);
  }

  /*
   * Actions
   */

  Request edit(String venueId, [String name, String address,
      String crossStreet, String city, String state, String zip, String phone,
      String twitter, String ll, String categoryId, String description,
      String url, Map<String, String> additional]) {
    Map<String, String> params = _combine({
      'name': name,
      'address': address,
      'crossStreet': crossStreet,
      'city': city,
      'state': state,
      'zip': zip,
      'phone': phone,
      'twitter': twitter,
      'll': ll,
      'categoryId': categoryId,
      'description': description,
      'url': url,
    }, additional);
    return _requestFactory.build('POST', '$endpoint/$venueId/edit', params);
  }

  Request flag(String venueId, [Map<String, String> additional]) {
    return _requestFactory.build('POST', '$endpoint/$venueId/flag',
        additional);
  }

  Request marktodo(String venueId, [String text,
      Map<String, String> additional]) {
    Map<String, String> params = _combine({
      'text': text,
    }, additional);
    return _requestFactory.build('POST', '$endpoint/$venueId/marktodo',
        params);
  }

  Request proposeedit(String venueId, [String name, String address,
      String crossStreet, String city, String state, String zip, String phone,
      String ll, String primaryCategoryId, Map<String, String> additional]) {
    Map<String, String> params = _combine({
      'name': name,
      'address': address,
      'crossStreet': crossStreet,
      'city': city,
      'state': state,
      'zip': zip,
      'phone': phone,
      'll': ll,
      'primaryCategoryId': primaryCategoryId,
    }, additional);
    return _requestFactory.build('POST', '$endpoint/$venueId/proposeedit',
        params);
  }
}
