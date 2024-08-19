import 'package:flutter/material.dart';
import 'package:movieapp/style/app_colors.dart';

class SearchBarItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.06),
      child: SearchBar(
        shape: WidgetStatePropertyAll(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
            side: const BorderSide(color: AppColors.lightGrayColor))),
        hintStyle: const WidgetStatePropertyAll(TextStyle(color: Colors.grey)),
        hintText: 'Search',
        padding: const WidgetStatePropertyAll(
            EdgeInsets.symmetric(vertical: 8, horizontal: 25)),
        backgroundColor: WidgetStatePropertyAll(AppColors.grayColor),
        leading: const Icon(
          Icons.search,
          color: AppColors.whiteColor,
        ),
        textStyle:
            WidgetStatePropertyAll(Theme.of(context).textTheme.titleSmall),
      ),
    );
  }
}
