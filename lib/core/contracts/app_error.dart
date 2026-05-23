enum AppErrorType {
  validation,
  notFound,
  conflict,
  unauthorized,
  network,
  unexpected,
}

class AppError {
  final AppErrorType type;
  final String message;
  final Object? cause;

  const AppError({
    required this.type,
    required this.message,
    this.cause,
  });
}
