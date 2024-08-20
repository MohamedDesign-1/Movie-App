import 'package:flutter/material.dart';
import 'package:movieapp/screens/search_screen/search_bar_item.dart';
import 'package:movieapp/style/app_colors.dart';

class SearchScreen extends StatelessWidget {
  static const String routeName = "SearchScreen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SearchBarItem(),
          Expanded(
            child: ListView.builder(
              itemCount: 7,
              padding: EdgeInsets.all(15),
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom:
                              BorderSide(color: AppColors.mediumGrayColor))),
                  height: MediaQuery.of(context).size.height * 0.2,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.133,
                        width: MediaQuery.of(context).size.height * 0.2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Image.asset(
                          'assets/images/stamp listview.png',
                          height: MediaQuery.of(context).size.height * 0.133,
                          width: MediaQuery.of(context).size.height * 0.21,
                          fit: BoxFit.fill,
                        ),

                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Alita Battle Angel',
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(color: AppColors.lightGrayColor),
                            ),
                            Text('2019'),
                            Text('Rosa Salazar, Christoph Waltz')
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
