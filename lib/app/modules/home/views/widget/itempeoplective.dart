import 'package:flutter/material.dart';

import '../../../../utils/data.dart';

class ItemPeopleActive extends StatelessWidget {
  const ItemPeopleActive({
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
      margin: EdgeInsets.symmetric(
        vertical: 10,
      ),
      // color: Colors.amber,
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
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: 18,
            ),
          )
        ],
      ),
    );
  }
}
