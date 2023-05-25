import 'package:flutter/material.dart';
import 'package:messenger/app/modules/home/views/widget/itempeoplective.dart';
import 'package:messenger/app/utils/data.dart';

import '../widget/itempeoplecommunities.dart';
import '../widget/itempeopleupdates.dart';

class IndexPeople extends StatelessWidget {
  const IndexPeople({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ListView(
      physics: const ClampingScrollPhysics(),
      padding: EdgeInsets.symmetric(
        horizontal: 10,
      ),
      children: [
        Row(
          children: [
            Text(
              "Facebook updates (6)",
              style: TextStyle(
                color: Colors.black38,
                fontSize: 16,
              ),
            ),
            Spacer(),
            TextButton(
              onPressed: () {},
              child: Text(
                "SEE ALL",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
        ListView.builder(
          itemCount: 3,
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          itemBuilder: (context, index) {
            return ItemPeopleUpdates(
              urlimage: "https://randomuser.me/api/portraits/men/1.jpg",
              name: "Irfan",
              notif: "added a new photo",
              time: "1d",
            );
          },
        ),
        SizedBox(
          height: 7,
        ),
        Text(
          "Chats in your communities",
          style: TextStyle(
            color: Colors.black38,
            fontSize: 16,
          ),
        ),
        ListView.builder(
          itemCount: 3,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return ItemPeopleCommunities(
              leading: Icon(
                Icons.messenger_rounded,
                color: Colors.white,
                size: 28,
              ),
              title: listgroup[index].keys.first,
              subtitle: listgroup[index].values.first,
            );
          },
        ),
        SizedBox(
          height: 7,
        ),
        const Text(
          "Active now (26)",
          style: TextStyle(
            color: Colors.black38,
            fontSize: 16,
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: listname.length,
          itemBuilder: (context, index) {
            return ItemPeopleActive(
              online: listonline[index],
              urlimage: 'https://randomuser.me/api/portraits/men/$index.jpg',
              title: listname[index],
            );
          },
        ),
      ],
    );
  }
}
