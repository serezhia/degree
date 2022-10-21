class Token {
  final int id;
  final int userId;
  final String refreshToken;
  final DateTime expireDate;

  Token({
    required this.id,
    required this.userId,
    required this.refreshToken,
    required this.expireDate,
  });
}
