import 'package:fpdart/fpdart.dart';

import 'package:animo/models/api_response.dart';
import 'package:animo/models/failure.dart';

typedef FutureEither<T> = Future<Either<Failure, T>>;
typedef FutureVoid = FutureEither<void>;
typedef OTPVerification = FutureEither<ApiResponse> Function(String);
