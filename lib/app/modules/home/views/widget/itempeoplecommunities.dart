import 'package:flutter/material.dart';

class ItemPeopleCommunities extends StatelessWidget {
  const ItemPeopleCommunities({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.leading,
  }) : super(key: key);
  final String title, subtitle;
  final Widget leading;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Container(
            height: size.height * 0.06,
            width: size.height * 0.06,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(200),
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Colors.black.withOpacity(0.05),
                  Colors.grey.withOpacity(0.7),
                ],
              ),
            ),
            child: leading,
          ),
          SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                subtitle,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
