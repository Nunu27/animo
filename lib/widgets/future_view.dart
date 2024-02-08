import 'package:animo/widgets/error_view.dart';
import 'package:animo/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class FutureView<T> extends StatelessWidget {
  final Future<T>? future;
  final RefreshController? refreshController;
  final Widget Function(T) onData;
  final VoidCallback? onRetry;

  const FutureView({
    super.key,
    this.refreshController,
    required this.future,
    required this.onData,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (refreshController?.isRefresh ?? false) {
            refreshController!.refreshCompleted();
          }

          return onData(snapshot.data as T);
        } else if (snapshot.hasError) {
          if (refreshController?.isRefresh ?? false) {
            refreshController!.refreshFailed();
          }

          return ErrorView(
            message: snapshot.error.toString(),
            onRetry: onRetry,
          );
        } else {
          return const Loader();
        }
      },
    );
  }
}
