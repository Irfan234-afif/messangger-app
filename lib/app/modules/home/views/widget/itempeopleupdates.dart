import 'package:flutter/material.dart';

class ItemPeopleUpdates extends StatelessWidget {
  const ItemPeopleUpdates({
    Key? key,
    required this.urlimage,
    required this.name,
    required this.notif,
    required this.time,
  }) : super(key: key);
  final String urlimage, name, notif, time;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.06,
      margin: EdgeInsets.only(
        bottom: 10,
      ),
      // color: Colors.amber,
      child: Row(
        children: [
          SizedBox(
            height: size.height * 0.06,
            width: size.height * 0.06,
            child: CircleAvatar(
              backgroundColor: Color.fromARGB(255, 235, 235, 235),
              foregroundImage: NetworkImage(urlimage),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          RichText(
            text: TextSpan(
              text: "$name ",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
              children: [
                TextSpan(
                  text: notif,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w300,
                    fontSize: 16,
                    wordSpacing: 1,
                    letterSpacing: 0.7,
                  ),
                ),
                TextSpan(
                  text: " • $time",
                  style: TextStyle(
                    color: Colors.black38,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
