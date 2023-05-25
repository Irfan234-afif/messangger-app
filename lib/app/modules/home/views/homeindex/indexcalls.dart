import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:messenger/app/utils/data.dart';

import '../widget/itemcalls.dart';

class IndexCalls extends StatelessWidget {
  const IndexCalls({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 10),
      physics: ClampingScrollPhysics(),
      children: [
        SizedBox(
          height: size.height * 0.4,
          width: size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "No calls",
                style: TextStyle(
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w600,
                  fontSize: 24,
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                "Recent calls wll appear here.",
                style: TextStyle(
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w300,
                  fontSize: 17.5,
                ),
              ),
              SizedBox(
                height: 8,
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: Text(
                  "START A CALL",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
        Text(
          "Suggestions",
          textAlign: TextAlign.start,
          style: TextStyle(
            color: Colors.black45,
            fontSize: 17,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        ListView.builder(
          itemCount: 10,
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          itemBuilder: (context, index) {
            return ItemCalls(
              urlimage: 'https://randomuser.me/api/portraits/men/$index.jpg',
              title: listname[index],
              online: listonline[index],
            );
          },
        ),
      ],
    );
  }
}
