import 'package:animo/utils/utils.dart';
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
  final bool fullPageLoadingView;

  const FutureView({
    super.key,
    this.refreshController,
    required this.future,
    required this.onData,
    this.onLoading,
    this.fullPageLoadingView = true,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        final bool isDone = fullPageLoadingView
            ? snapshot.connectionState == ConnectionState.done
            : true;

        if (snapshot.hasError && isDone) {
          if (refreshController?.isRefresh ?? false) {
            refreshController!.refreshFailed();
          }
          if (refreshController?.isLoading ?? false) {
            refreshController!.loadFailed();
          }

          return ErrorView(
            message: getError(snapshot.error).message,
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
