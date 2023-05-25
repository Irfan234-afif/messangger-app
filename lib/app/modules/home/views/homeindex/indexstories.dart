import 'package:flutter/material.dart';
import 'package:messenger/app/utils/data.dart';

class IndexStories extends StatelessWidget {
  const IndexStories({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 3 / 4,
      ),
      itemCount: 10,
      itemBuilder: (BuildContext context, int index) {
        return Stack(
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                vertical: 13,
                horizontal: 13,
              ),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    'https://picsum.photos/seed/${index + 50}/200/300',
                  ),
                ),
              ),
              child: index == 0
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(40 / 2),
                              ),
                              child: Icon(
                                Icons.add_rounded,
                                size: 32,
                              ),
                            ),
                            SizedBox(),
                          ],
                        ),
                        Text(
                          'Add to story',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                          ),
                        )
                      ],
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              padding: EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                border: Border.all(
                                  color: Colors.blue,
                                  width: 3,
                                ),
                                borderRadius: BorderRadius.circular(50 / 2),
                              ),
                              child: CircleAvatar(
                                foregroundImage: NetworkImage(
                                  'https://randomuser.me/api/portraits/men/$index.jpg',
                                ),
                              ),
                            ),
                            Chip(
                              label: Text('1'),
                            ),
                          ],
                        ),
                        Text(
                          listname[index],
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                          ),
                        )
                      ],
                    ),
            ),
            Positioned.fill(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {},
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
