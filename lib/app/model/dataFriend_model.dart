// To parse this JSON data, do
//
//     final dataFriend = dataFriendFromJson(jsonString);

import 'dart:convert';

List<DataFriend> dataFriendFromJson(String str) =>
    List<DataFriend>.from(json.decode(str).map((x) => DataFriend.fromJson(x)));

String dataFriendToJson(List<DataFriend> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ListDataFriend {
  List<DataFriend>? listDataFriend;

  ListDataFriend({
    this.listDataFriend,
  });

  factory ListDataFriend.fromJson(Map<String, dynamic> json) => ListDataFriend(
        listDataFriend: json['chats'] == null
            ? []
            : List<DataFriend>.from(
                json['chats']!.map(
                  (x) => DataFriend.fromJson(x),
                ),
              ),
      );

  Map<String, dynamic> toJson() => {
        "DataFriend": listDataFriend == null
            ? []
            : List<dynamic>.from(listDataFriend!.map((e) => e.toJson()))
      };
}

class DataFriend {
  String? email;
  String? creationtime;
  String? keyname;
  String? lastsignin;
  String? nama;
  String? photourl;
  String? uid;
  String? updatetime;

  DataFriend({
    this.email,
    this.creationtime,
    this.keyname,
    this.lastsignin,
    this.nama,
    this.photourl,
    this.uid,
    this.updatetime,
  });

  factory DataFriend.fromJson(Map<String, dynamic> json) => DataFriend(
        email: json["email"],
        creationtime: json["creationtime"],
        keyname: json["keyname"],
        lastsignin: json["lastsignin"],
        nama: json["nama"],
        photourl: json["photourl"],
        uid: json["uid"],
        updatetime: json["updatetime"],
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
      };
}
