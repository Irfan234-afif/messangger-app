import 'package:flutter/material.dart';

class ItemCalls extends StatelessWidget {
  const ItemCalls({
    Key? key,
    required this.urlimage,
    required this.title,
    required this.online,
  }) : super(key: key);

  final String urlimage, title;
  final bool online;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.06,
      // color: Colors.amber,
      margin: EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: Row(
        children: [
          Container(
            height: size.height * 0.06,
            width: size.height * 0.06,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(size.height * 0.06 / 2),
              image: DecorationImage(
                image: NetworkImage(
                  urlimage,
                ),
              ),
            ),
            child: Align(
              alignment: Alignment(1, 0.9),
              child: online
                  ? Container(
                      height: 17,
                      width: 17,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        border: Border.all(
                          color: Colors.white,
                          width: 3,
                        ),
                        borderRadius: BorderRadius.circular(17 / 2),
                      ),
                    )
                  : SizedBox(),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
          Spacer(
            flex: 3,
          ),
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 235, 235, 235),
              borderRadius: BorderRadius.circular(40 / 2),
            ),
            child: Icon(Icons.call_rounded, color: Colors.black),
          ),
          SizedBox(
            width: 10,
          ),
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 235, 235, 235),
              borderRadius: BorderRadius.circular(40 / 2),
            ),
            child: Icon(Icons.videocam_rounded, color: Colors.black),
          ),
        ],
      ),
    );
  }
}
