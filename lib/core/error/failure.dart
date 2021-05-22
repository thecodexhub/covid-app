import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {}

// General Failures
class ServerFailure extends Failure {
  @override
  List<Object> get props => [];
}

class CacheFailure extends Failure {
  @override
  List<Object> get props => [];
}

const String SERVER_FAILURE_MESSAGE = 'serverFailureMessage';
const String CACHE_FAILURE_MESSAGE = 'cacheFailureMessage';

extension FailureX on Failure {
  String get mapFailureToMessage {
    switch (this.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      default:
        return 'unexpectedFailureMessage';
    }
  }
}
