class Errors {
  final String message;
  const Errors(this.message);
}

class ServerError extends Errors {
  const ServerError(super.message);
}

class NetworkError extends Errors {
  const NetworkError(super.message);
}

class UnexpectedError extends Errors {
  const UnexpectedError(super.message);
}
