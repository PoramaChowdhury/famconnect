class UserModel {
  final String uid;
  final String? name;
  final String? email;
  final String? phone;
  final String? dob;
  final bool? isMarried;
  final String? anniversary;
  final String? weeklyOff;

  UserModel({
    required this.uid,
    this.name,
    this.email,
    this.phone,
    this.dob,
    this.isMarried,
    this.anniversary,
    this.weeklyOff,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'],
      name: map['name'],
      email: map['email'],
      phone: map['phone'],
      dob: map['dob'],
      isMarried: map['isMarried'],
      anniversary: map['anniversary'],
      weeklyOff: map['weeklyOff'],
    );
  }


  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'phone': phone,
      'dob': dob,
      'isMarried': isMarried,
      'anniversary': anniversary,
      'weeklyOff': weeklyOff,
    };
  }
}
