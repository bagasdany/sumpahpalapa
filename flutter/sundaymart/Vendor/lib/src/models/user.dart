class User {
  final int? id;
  String? name;
  String? surname;
  String? imageUrl;
  String? phone;
  String? email;
  String? password;
  int? gender;
  final String? token;
  int? process;
  int? earnMark;
  int? idShop;
  double? totalBalance;
  double? dailyBalance;
  List<String>? permissions;
  int role;

  User(
      {this.name,
      this.id,
      this.surname,
      this.imageUrl,
      this.phone = "",
      this.email = "",
      this.password = "",
      this.token,
      this.gender = 0,
      this.process = 0,
      this.earnMark = 0,
      this.idShop,
      this.totalBalance = 0,
      this.dailyBalance = 0,
      this.role = 2,
      this.permissions = const []});

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "surname": surname,
      "imageUrl": imageUrl,
      "phone": phone,
      "email": email,
      "token": token,
      "gender": gender,
      "password": password,
      "idShop": idShop,
      "totalBalance": totalBalance,
      "role": role,
      //"permissions": permissions.toString()
    };
  }

  static User fromJson(dynamic json) {
    return User(
        id: json['id'],
        name: json['name'],
        surname: json['surname'],
        imageUrl: json['imageUrl'],
        phone: json['phone'],
        email: json['email'],
        token: json['token'],
        password: json['password'],
        gender: json['gender'],
        idShop: json['idShop'],
        totalBalance: json['totalBalance'],
        dailyBalance: json['dailyBalance'],
        role: json["id_role"] ?? 1
        //permissions: json['permissions'].toList()
        );
  }
}
