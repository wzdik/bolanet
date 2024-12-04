import 'package:bolanet76/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  String titleText;

  CustomAppBar({
    super.key,
    required this.titleText,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(titleText),
      actions: <Widget>[
        PopupMenuButton<int>(
          onSelected: (value) {
            if (value == 0) {
              Get.toNamed(Routes.HTTP); // Navigasi ke HTTP Page
            }
          },
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 0,
              child: Text("HTTP Page"),
            ),
          ],
        ),
      ],
    );
  }
}
