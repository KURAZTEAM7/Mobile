class User {
  final String firstName;
  final String middleName;
  final String lastName;
  final String email;
  final String password;
  final String passwordConfirmation;

  User({
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.passwordConfirmation,
  });

  Map<String, dynamic> toJson() {
    return {
      'first_name': firstName,
      'middle_name': middleName,
      'last_name': lastName,
      'email': email,
      'password': password,
      'password_confirmation': passwordConfirmation, 
    };
  }
}