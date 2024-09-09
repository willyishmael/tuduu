import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  const Failure({required this.message});

  @override
  List<Object?> get props => [message];
}

class ServerFailure extends Failure with EquatableMixin {
  final String? stackTrace;
  const ServerFailure({
    required super.message,
    this.stackTrace,
  });

  @override
  List<Object?> get props => [message, stackTrace];
}

class CubitFailure extends Failure with EquatableMixin {
  final String? stackTrace;
  const CubitFailure({
    required super.message,
    this.stackTrace,
  });

  @override
  List<Object?> get props => [message, stackTrace];
}

class EmptyResponseFailure extends Failure with EquatableMixin {
  const EmptyResponseFailure({required super.message});

  @override
  List<Object?> get props => [message];
}
