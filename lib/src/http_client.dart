import 'package:external_dependencies/external_dependencies.dart';

abstract class HttpClient {
  Future<ClientResponse> get(String url);
  Future<ClientResponse> post(String url, {Map<String, dynamic>? body, Map<String, String>? customHeaders});
  Future<ClientResponse> put(String url, {Map<String, dynamic>? body, Map<String, String>? customHeaders});
  Future<ClientResponse> delete(String url, {Map<String, String>? customHeaders});
}

class ClientResponse {
  final dynamic data;
  final int statusCode;

  ClientResponse({required this.data, required this.statusCode});
}

class DioHttpService implements HttpClient {
  final Dio _dio;

  const DioHttpService(this._dio, {List<Interceptor> interceptors = const []});

  @override
  Future<ClientResponse> delete(String url, {Map<String, String>? customHeaders}) async {
    Options? options;
    if (customHeaders != null) options = Options(headers: customHeaders);
    return _dio.delete(url, options: options).then((dioResponse) => ClientResponse(data: dioResponse.data, statusCode: dioResponse.statusCode ?? 0));
  }

  @override
  Future<ClientResponse> get(String url) {
    return _dio.get(url).then((dioResponse) => ClientResponse(data: dioResponse.data, statusCode: dioResponse.statusCode ?? 0));
  }

  @override
  Future<ClientResponse> post(String url, {Map<String, dynamic>? body, Map<String, String>? customHeaders}) {
    Options? options;
    if (customHeaders != null) options = Options(headers: customHeaders);
    return _dio.post(url, data: body, options: options).then((dioResponse) => ClientResponse(data: dioResponse.data, statusCode: dioResponse.statusCode ?? 0));
  }

  @override
  Future<ClientResponse> put(String url, {Map<String, dynamic>? body, Map<String, String>? customHeaders}) {
    Options? options;
    if (customHeaders != null) options = Options(headers: customHeaders);
    return _dio.put(url, data: body, options: options).then((dioResponse) => ClientResponse(data: dioResponse.data, statusCode: dioResponse.statusCode ?? 0));
  }

  // DioHttpService({List<Interceptor> interceptors = const []}) : super() {
  //   if (interceptors.isNotEmpty) super.interceptors.addAll(interceptors);
  // }
}
