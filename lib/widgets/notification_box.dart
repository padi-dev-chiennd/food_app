
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NotificationBox extends StatelessWidget {
  const NotificationBox({super.key, this.number = 0, this.onTap});

  final int number;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.grey.withOpacity(.3),
          ),
        ),
        child: number > 0 ? _buildNofiedIcon() : _buildIcon(),
      ),
    );
  }

  _buildNofiedIcon() {
    return Container(
      padding: const EdgeInsets.all(3),
      // position: BadgePosition.topEnd(top: -7, end: 2),
      // badgeContent: Text(
      //   '',
      //   style: TextStyle(color: Colors.white),
      // ),
      child: _buildIcon(),
    );
  }

  _buildIcon() {
    return const Icon(
      FontAwesomeIcons.solidBell,
      size: 20,
    );
  }
}
