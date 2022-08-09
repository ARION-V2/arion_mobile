class ApiReturnValue<T> {
  final T? value;
  final String? message;
  const ApiReturnValue({
    this.value,
    this.message,
  });

  ApiReturnValue copyWith({
    T? value,
    String? message,
  }) {
    return ApiReturnValue(
      value: value ?? this.value,
      message: message ?? this.message,
    );
  }
}
