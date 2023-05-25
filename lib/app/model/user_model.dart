// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String? email;
  String? creationtime;
  String? keyname;
  String? lastsignin;
  String? nama;
  String? photourl;
  String? uid;
  String? updatetime;
  List<Chat>? chat;

  UserModel({
    this.email,
    this.creationtime,
    this.keyname,
    this.lastsignin,
    this.nama,
    this.photourl,
    this.uid,
    this.updatetime,
    this.chat,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        email: json["email"],
        creationtime: json["creationtime"],
        keyname: json["keyname"],
        lastsignin: json["lastsignin"],
        nama: json["nama"],
        photourl: json["photourl"],
        uid: json["uid"],
        updatetime: json["updatetime"],
        chat: json["chat"] == null
            ? []
            : List<Chat>.from(json["chat"]!.map((x) => Chat.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "creationtime": creationtime,
        "Keyname": keyname,
        "lastsignin": lastsignin,
        "nama": nama,
        "photourl": photourl,
        "uid": uid,
        "updatetime": updatetime,
        "chat": chat == null
            ? []
            : List<dynamic>.from(chat!.map((x) => x.toJson())),
      };

  bool chatbool(List<Chat>? object) {
    if (chat != null) {
      if (object == null) {
        return false;
      }
      if (object.length != chat!.length) {
        return false;
      }
      List<bool> listBool = List.generate(chat!.length, (index) {
        var halo = chat![index].connection == object[index].connection &&
            chat![index].lastime == object[index].lastime &&
            chat![index].totalUnread == object[index].totalUnread;
        return halo;
      });
      if (listBool.contains(false)) {
        return false;
      } else {
        return true;
      }
    } else {
      return false;
    }
  }

  bool checkStream(Map<String, dynamic> data) {
    var check = email == data['email'] &&
        uid == data['uid'] &&
        creationtime == data['creationtime'] &&
        keyname == data['keyname'] &&
        lastsignin == data['lastsignin'] &&
        photourl == data['photourl'] &&
        updatetime == data['updatetime'];
    return check;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModel &&
          runtimeType == other.runtimeType &&
          email == other.email &&
          nama == other.nama &&
          uid == other.uid &&
          creationtime == other.creationtime &&
          lastsignin == other.lastsignin &&
          updatetime == other.updatetime &&
          keyname == other.keyname &&
          photourl == other.photourl &&
          other.chat is Chat;
  // chatbool(other.chat);

  @override
  int get hashCode => nama.hashCode;

  // @override
  // bool operator ==(Object other) =>
  // identical(chat, other) ||
}

class Chat {
  String? uid;
  String? connection;
  String? lastime;
  int? totalUnread;

  Chat({
    this.uid,
    this.connection,
    this.lastime,
    this.totalUnread,
  });

  factory Chat.fromJson(Map<String, dynamic> json) => Chat(
        uid: json["uid"],
        connection: json["connection"],
        lastime: json["lastime"],
        totalUnread: json["total_unread"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "connection": connection,
        "lastime": lastime,
        "total_unread": totalUnread,
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Chat &&
          runtimeType == other.runtimeType &&
          connection == other.connection &&
          lastime == other.lastime &&
          totalUnread == other.totalUnread;

  @override
  int get hashCode => connection.hashCode;
}
