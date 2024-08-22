class ResultController<T> {
  final T? data;
  final String? error;
  final String? status;
  ResultController({this.data, this.error, this.status});
}
