class ResponsePaginate<T> {
  final T value;
  final int currentPage, totalPage;
  ResponsePaginate({
    required this.value,
    required this.currentPage,
    required this.totalPage,
  });
}
