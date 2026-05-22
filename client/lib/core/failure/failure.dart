class AppFailure {
  final String message;
  AppFailure([this.message = 'Désolé, une erreur instendue est survenue !']);

  @override
  String toString() => 'AppFailure(message: $message)';
}
