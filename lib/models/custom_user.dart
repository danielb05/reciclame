class CustomUser {
  final String uid;
  final bool isAdmin;
  final String fullName;
  final String avatarRef;
  final String city;
  final String postalCode;
  final int score;
  final bool enable;

  CustomUser(
      this.uid,
      this.isAdmin,
      this.fullName,
      this.avatarRef,
      this.city,
      this.postalCode,
      this.score,
      this.enable);

  Map<String, dynamic> toJson() => {
    'uid': uid,
    'isAdmin': isAdmin,
    'fullName':fullName,
    'avatarRef':avatarRef,
    'city':city,
    'postalCode':postalCode,
    'score':score,
    'enable':enable
  };
}