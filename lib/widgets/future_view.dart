import 'package:animo/widgets/error_view.dart';
import 'package:animo/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class FutureView<T> extends StatelessWidget {
  final Future<T>? future;
  final RefreshController? refreshController;
  final Widget Function(T data) onData;
  final Widget Function()? onLoading;
  final VoidCallback? onRetry;

  const FutureView({
    super.key,
    this.refreshController,
    required this.future,
    required this.onData,
    this.onLoading,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        final isDone = snapshot.connectionState == ConnectionState.done;

        if (snapshot.hasError && isDone) {
          return ErrorView(
            message: snapshot.error.toString(),
            onRetry: onRetry,
          );
        } else if (snapshot.hasData && isDone) {
          return onData(snapshot.data as T);
        } else {
          return onLoading == null ? const Loader() : onLoading!();
        }
      },
    );
  }
}
