import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ErrorView extends StatelessWidget {
  final Widget icon;
  final Object error;
  final VoidCallback? onRetry;

  const ErrorView({
    super.key,
    this.icon = const Icon(
      Icons.error_outline_outlined,
      size: 30,
    ),
    required this.error,
    this.onRetry,
  });

  String _getDioError(DioException e) {
    return switch (e.type) {
      DioExceptionType.connectionTimeout => 'Connection timed out.',
      DioExceptionType.sendTimeout => 'Send request timed out.',
      DioExceptionType.receiveTimeout => 'Receive response timed out.',
      DioExceptionType.badCertificate => 'Bad certificate error.',
      DioExceptionType.badResponse => switch (e.response?.statusCode) {
          429 => 'Too many request',
          _ => 'Received an invalid response.',
        },
      DioExceptionType.cancel => 'Request was cancelled.',
      DioExceptionType.connectionError => 'Connection error occurred.',
      DioExceptionType.unknown => 'An unknown error occurred.',
    };
  }

  String _getMessage() {
    final error = this.error;

    return switch (error) {
      DioException() => _getDioError(error),
      _ => error.toString(),
    };
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          icon,
          const SizedBox(
            height: 4,
          ),
          Text(_getMessage(), textAlign: TextAlign.center),
          const SizedBox(
            height: 20,
          ),
          if (onRetry != null)
            FilledButton(
              style: FilledButton.styleFrom(
                visualDensity: VisualDensity.compact,
              ),
              onPressed: onRetry!,
              child: const Text('Try again'),
            )
        ],
      ),
    );
  }
}
