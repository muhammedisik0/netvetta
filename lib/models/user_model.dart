class User {
  final int id;
  final String code;
  final String phoneNumber;
  final String password;

  User({
    required this.id,
    required this.code,
    required this.phoneNumber,
    required this.password,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'],
        code: json['code'],
        phoneNumber: json['phoneNumber'],
        password: json['password'],
      );

  User copyWith(
      {int? id, String? code, String? phoneNumber, String? password}) {
    return User(
      id: id ?? this.id,
      code: code ?? this.code,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toApiJson() => {
        'kk': code,
        'tel': phoneNumber,
        'parola': password,
      };

  Map<String, dynamic> toJson() => {
        'id': id,
        'code': code,
        'phoneNumber': phoneNumber,
        'password': password,
      };
}
