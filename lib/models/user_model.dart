class User {
  final int id;
  final String userCode;
  final String phoneNumber;
  final String password;

  User({
    required this.id,
    required this.userCode,
    required this.phoneNumber,
    required this.password,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'],
        userCode: json['userCode'],
        phoneNumber: json['phoneNumber'],
        password: json['password'],
      );

  User copyWith(
      {int? id, String? userCode, String? phoneNumber, String? password}) {
    return User(
      id: id ?? this.id,
      userCode: userCode ?? this.userCode,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toApiJson() => {
        'kk': userCode,
        'tel': phoneNumber,
        'parola': password,
      };

  Map<String, dynamic> toJson() => {
        'id': id,
        'userCode': userCode,
        'phoneNumber': phoneNumber,
        'password': password,
      };
}
