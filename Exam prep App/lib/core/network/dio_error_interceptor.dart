import 'package:dio/dio.dart';

class DioErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response != null) {
      if (err.response!.statusCode! >= 300) {
        err = DioException(
          requestOptions: err.requestOptions,
          response: err.response,
          error: err.response!.data['message'] ?? err.response!.statusMessage!,
          type: err.type,
        );
      } else {
        err = DioException(
          requestOptions: err.requestOptions,
          response: err.response,
          error: 'Something went wrong!',
          type: err.type,
        );
      }
    } else {
      // Handle Connection Errors
      err = DioException(
        requestOptions: err.requestOptions,
        error: 'Connection Error!',
        type: err.type,
      );
    }
    super.onError(err, handler);
  }
}
