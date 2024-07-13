class User {
  final int id;
  final String email;
  final String username;
  final String password;
  final Map<String, dynamic> name;
  final String phone;
  final Map<String, dynamic> address;

  const User(
      {required this.id,
      required this.email,
      required this.username,
      required this.password,
      required this.name,
      required this.phone,
      required this.address});

  factory User.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': int id,
        'email': String email,
        'username': String username,
        'password': String password,
        'name': Map<String, dynamic> name,
        'phone': String phone,
        'address': Map<String, dynamic> address,
      } =>
        User(
            id: id,
            email: email,
            username: username,
            password: password,
            name: name,
            phone: phone,
            address: address),
      _ => throw const FormatException('Failed to load User'),
    };
  }
}
