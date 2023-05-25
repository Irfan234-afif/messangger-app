import 'package:flutter/material.dart';

class ItemChatRoom extends StatelessWidget {
  ItemChatRoom({
    Key? key,
    required this.msg,
    required this.sender,
    required this.onLongPress,
    this.nextchat = false,
  }) : super(key: key);

  final String msg;
  final bool sender;
  final Function() onLongPress;
  bool nextchat;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: onLongPress,
      child: Align(
        alignment: sender ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          constraints: const BoxConstraints(
            maxWidth: 280,
          ),
          margin: EdgeInsets.only(
            top: nextchat ? 2 : 10,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 10,
          ),
          decoration: BoxDecoration(
            color: sender ? Colors.blueAccent[700] : Colors.grey[300],
            borderRadius: BorderRadius.circular(15),
          ),
          child: Text(
            msg,
            style: TextStyle(
              color: sender ? Colors.white : Colors.black,
              fontSize: 17,
            ),
          ),
        ),
      ),
    );
  }
}
