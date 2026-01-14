class MoviesRepositoryResult<T> {
  final T? data;
  final String? errorMessage;

  const MoviesRepositoryResult.success(this.data) : errorMessage = null;
  const MoviesRepositoryResult.failure(this.errorMessage) : data = null;

  bool get isSuccess => data != null;
}