import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class ItemBottomSheet extends StatelessWidget {
  ItemBottomSheet({
    Key? key,
    required this.icon,
    required this.color,
    required this.label,
    this.size = 29,
    required this.ontap,
  }) : super(key: key);

  final IconData icon;
  final String label;
  final Color color;
  final Function() ontap;
  double? size;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(100),
        splashColor: Colors.transparent,
        overlayColor: MaterialStateProperty.all(Colors.transparent),
        onTap: ontap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Icon(
              icon,
              color: color,
              size: size,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 12,
              ),
            )
          ],
        ),
      ),
    );
  }
}
