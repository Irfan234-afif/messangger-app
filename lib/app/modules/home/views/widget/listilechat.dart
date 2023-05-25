import 'package:flutter/material.dart';

class ListTileItemChat extends StatelessWidget {
  const ListTileItemChat({
    super.key,
    required this.index,
    required this.title,
    required this.subtitle,
    required this.time,
    required this.urlimage,
    required this.ontap,
    required this.totalUnread,
  });

  final int index;
  final String title, subtitle, time, totalUnread;
  final String? urlimage;
  final Function() ontap;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          height: size.height * 0.095,
          width: size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 65,
                width: 65,
                child: CircleAvatar(
                  backgroundColor: Colors.grey[400],
                  child: urlimage == null
                      ? Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 35,
                        )
                      : Image.asset(urlimage!),
                ),
              ),
              SizedBox(
                width: 13,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text: "$subtitle • ",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                        height: 1.6,
                      ),
                      children: [
                        TextSpan(
                          text: time,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Spacer(),
              totalUnread != '0'
                  ? Chip(
                      label: Text(
                        totalUnread,
                      ),
                    )
                  : SizedBox(),
            ],
          ),
        ),
        Positioned.fill(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              overlayColor:
                  MaterialStateProperty.all(Color.fromARGB(80, 237, 237, 237)),
              borderRadius: BorderRadius.circular(10),
              onTap: ontap,
            ),
          ),
        ),
      ],
    );
  }
}
