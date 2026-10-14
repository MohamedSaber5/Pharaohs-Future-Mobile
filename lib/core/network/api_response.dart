enum ApiStatus { initial, loading, success, error }

class ApiResponse<T> {
  final ApiStatus status;
  final T? data;
  final String? errorMessage;

  ApiResponse.initial()
      : status = ApiStatus.initial,
        data = null,
        errorMessage = null;

  ApiResponse.loading()
      : status = ApiStatus.loading,
        data = null,
        errorMessage = null;

  ApiResponse.success(this.data)
      : status = ApiStatus.success,
        errorMessage = null;

  ApiResponse.error(this.errorMessage)
      : status = ApiStatus.error,
        data = null;

  bool get isLoading => status == ApiStatus.loading;
  bool get isSuccess => status == ApiStatus.success;
  bool get isError => status == ApiStatus.error;
}
