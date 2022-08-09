part of 'extensions.dart';

extension StateMixinCustom<T> on StateMixin<T> {
  Widget obxCustom(
    NotifierBuilder<T?> widget, {
    Widget Function(String? error)? onError,
    Widget? onLoading,
    Widget? onEmpty,
    required Function()? onRefreshData,
  }) {
    return SimpleBuilder(builder: (_) {
      if (status.isLoading) {
        return onLoading ??
            Center(
              child: loading(3, diameter: 40),
            );
      } else if (status.isError) {
        return onError != null
            ? onError(status.errorMessage)
            : DataErrorWidget(
                onRefresh: onRefreshData,
              );
      } else if (status.isEmpty) {
        return onEmpty ??
            const DataNotFoundWidget(); // Also can be widget(null); but is risky
      }

      // ignore: invalid_use_of_protected_member
      return widget(value);
    });
  }
}
