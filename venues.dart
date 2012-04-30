class _Venues extends _Endpoint {
  _Venues(_RequestFactory requestFactory) {
    this._endpoint = 'venues';
    this._requestFactory = requestFactory;
  }

  /*
   * General
   */

  _GetRequest get(String venueId, [Map<String, String> additional]) {
    return _requestFactory.build('GET', '$_endpoint/$venueId', additional);
  }

  _PostRequest add([String address, String crossStreet, String city,
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
    return _requestFactory.build('POST', '$_endpoint/add', params);
  }

  _GetRequest categories([Map<String, String> additional]) {
    return _requestFactory.build('GET', '$_endpoint/categories', additional);
  }

  _GetRequest explore([String ll, String near, num llAcc, int alt, num altAcc,
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
    return _requestFactory.build('GET', '$_endpoint/explore', params);
  }

  _GetRequest managed([Map<String, String> additional]) {
    return _requestFactory.build('GET', '$_endpoint/managed', additional);
  }

  _GetRequest search([String ll, String near, num llAcc, int alt, num altAcc,
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
    return _requestFactory.build('GET', '$_endpoint/search', params);
  }

  _GetRequest suggestcompletion(String ll, [num llAcc, int alt, num altAcc,
      String query, int limit, Map<String, String> additional]) {
    Map<String, String> params = _combine({
      'll': ll,
      'llAcc': llAcc.toString(),
      'alt': alt.toString(),
      'altAcc': altAcc.toString(),
      'query': query,
      'limit': limit.toString(),
    }, additional);
    return _requestFactory.build('GET', '$_endpoint/suggestcompletion', params);
  }

  _GetRequest timeseries(String venueId, [int startAt, int endAt,
      Map<String, String> additional]) {
    Map<String, String> params = _combine({
      'venueId': venueId,
      'startAt': startAt.toString(),
      'endAt': endAt.toString(),
    }, additional);
    return _requestFactory.build('GET', '$_endpoint/timeseries', params);
  }

  _GetRequest trending(String ll, [int limit, int radius,
      Map<String, String> additional]) {
    Map<String, String> params = _combine({
      'll': ll,
      'limit': limit.toString(),
      'radius': radius.toString(),
    }, additional);
    return _requestFactory.build('GET', '$_endpoint/trending', params);
  }

  /*
   * Aspects
   */

  _GetRequest events(String venueId, [Map<String, String> additional]) {
    return _requestFactory.build('GET', '$_endpoint/$venueId/events',
        additional);
  }

  _GetRequest herenow(String venueId, [int limit, int offset,
      int afterTimestamp, Map<String, String> additional]) {
    Map<String, String> params = _combine({
      'limit': limit.toString(),
      'offset': offset.toString(),
      'afterTimestamp': afterTimestamp.toString(),
    }, additional);
    return _requestFactory.build('GET', '$_endpoint/$venueId/herenow', params);
  }

  _GetRequest links(String venueId, [Map<String, String> additional]) {
    return _requestFactory.build('GET', '$_endpoint/$venueId/links',
        additional);
  }

  _GetRequest listed(String venueId, [String group, int limit, int offset,
      Map<String, String> additional]) {
    Map<String, String> params = _combine({
      'group': group,
      'limit': limit.toString(),
      'offset': offset.toString(),
    }, additional);
    return _requestFactory.build('GET', '$_endpoint/$venueId/listed', params);
  }

  _GetRequest menu(String venueId, [Map<String, String> additional]) {
    return _requestFactory.build('GET', '$_endpoint/$venueId/menu', additional);
  }

  _GetRequest photos(String venueId, String group, [int limit, int offset,
      Map<String, String> additional]) {
    Map<String, String> params = _combine({
      'group': group,
      'limit': limit.toString(),
      'offset': offset.toString(),
    }, additional);
    return _requestFactory.build('GET', '$_endpoint/$venueId/photos', params);
  }

  _GetRequest similar(String venueId, [Map<String, String> additional]) {
    return _requestFactory.build('GET', '$_endpoint/$venueId/similar',
        additional);
  }

  _GetRequest stats(String venueId, [int startAt, int endAt,
      Map<String, String> additional]) {
    Map<String, String> params = _combine({
      'startAt': startAt.toString(),
      'endAt': endAt.toString(),
    }, additional);
    return _requestFactory.build('GET', '$_endpoint/$venueId/stats', params);
  }

  _GetRequest tips(String venueId, [String sort, int limit, int offset,
       Map<String, String> additional]) {
    Map<String, String> params = _combine({
      'sort': sort,
      'limit': limit.toString(),
      'offset': offset.toString(),
    }, additional);
    return _requestFactory.build('GET', '$_endpoint/$venueId/tips', params);
  }

  /*
   * Actions
   */

  _PostRequest edit(String venueId, [String name, String address,
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
    return _requestFactory.build('POST', '$_endpoint/$venueId/edit', params);
  }

  _PostRequest flag(String venueId, [Map<String, String> additional]) {
    return _requestFactory.build('POST', '$_endpoint/$venueId/flag',
        additional);
  }

  _PostRequest marktodo(String venueId, [String text,
      Map<String, String> additional]) {
    Map<String, String> params = _combine({
      'text': text,
    }, additional);
    return _requestFactory.build('POST', '$_endpoint/$venueId/marktodo',
        params);
  }

  _PostRequest proposeedit(String venueId, [String name, String address,
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
    return _requestFactory.build('POST', '$_endpoint/$venueId/proposeedit',
        params);
  }
}
