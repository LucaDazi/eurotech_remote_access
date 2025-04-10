import 'dart:math';

String generatePassword() {
  final length = 16;
  final letterLowerCase = 'abcdefghijklmnopqrstuvwxyz';
  final letterUpperCase = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  final numbers = '0123456789';
  final specialCharacters = '!#\$%^&*()_+[]{}|;:,.<>?';

  String chars =
      letterLowerCase + letterUpperCase + numbers + specialCharacters;

  return List.generate(length, (index) {
    final randomIndex = Random().nextInt(chars.length);
    return chars[randomIndex];
  }).join('');
}
