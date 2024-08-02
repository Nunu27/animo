import 'package:fpdart/fpdart.dart';

Future<Either<Object, T>> handleError<T>(Future<T> func) async {
  try {
    return right(await func);
  } catch (e) {
    return left(e);
  }
}
