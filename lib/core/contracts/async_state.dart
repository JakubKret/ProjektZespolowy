import 'app_error.dart';

enum AsyncStatus { idle, loading, success, failure }

class AsyncState<T> {
  final AsyncStatus status;
  final T? data;
  final AppError? error;

  const AsyncState._({
    required this.status,
    this.data,
    this.error,
  });

  const AsyncState.idle() : this._(status: AsyncStatus.idle);

  const AsyncState.loading() : this._(status: AsyncStatus.loading);

  const AsyncState.success(T data)
      : this._(status: AsyncStatus.success, data: data);

  const AsyncState.failure(AppError error)
      : this._(status: AsyncStatus.failure, error: error);
}
