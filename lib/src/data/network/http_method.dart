enum HttpMethod {
  GET,
  POST,
  PUT,
  DELETE,
  PATCH,
}

extension HttpMethodExt on HttpMethod {
  String get name => toString().split('.').last;
}
