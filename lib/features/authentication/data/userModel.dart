class UserModel {
  final String name;
  final String email;
  final String phone;
  final String password;
  final String cpassword;

  UserModel(
      {required this.name,
      required this.email,
      required this.phone,
      required this.password,
      required this.cpassword});
}
