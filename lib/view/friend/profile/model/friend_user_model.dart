// ignore_for_file: public_member_api_docs, sort_constructors_first

class FriendUserModel {
  String id;
  String name;
  String nickname;
  List followers;
  String photoURL;
  FriendUserModel({
    required this.id,
    required this.name,
    required this.nickname,
    required this.followers,
    required this.photoURL
  });
}
