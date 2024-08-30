enum ResultsLevel { success, fail, notSupported }

class ResultController<T> {
  final T? data;
  final String? error;
  final ResultsLevel? status;
  ResultController({this.data, this.error, this.status});
}
