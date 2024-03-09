import 'package:flutter/material.dart';
import 'package:formfillpro/home_page/screens/pan_screen.dart';
import 'package:formfillpro/home_page/screens/second_screen.dart';
import 'package:formfillpro/home_page/tools/border.dart';
import 'package:formfillpro/home_page/tools/colors.dart';

import '../tools/text_style.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      color: greyColor,
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: width * 0.03,
                    vertical: 10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: getBorderRadiusWidget(context, 2),
                            child: Image.asset(
                              "assets/images/pic0.jpg",
                              width: width * 0.1,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: width * 0.02),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Welcome',
                                style: textColor9,
                              ),
                              Text(
                                'User',
                                style: textColor2,
                              ),
                            ],
                          )
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.all(width * 0.03),
                        decoration: BoxDecoration(
                          color: searchBarColor,
                          borderRadius: getBorderRadiusWidget(context, 0.03),
                        ),
                        child: const Icon(
                          Icons.notifications,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 50,
                  width: width * 0.94,
                  margin: const EdgeInsets.only(top: 30, bottom: 30),
                  padding: EdgeInsets.only(left: width * 0.03),
                  decoration: BoxDecoration(
                    color: searchBarColor,
                    borderRadius: getBorderRadiusWidget(context, 0.03),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.search_rounded,
                        color: primaryColor,
                        size: 28,
                      ),
                      SizedBox(width: width * 0.03),
                      const Text(
                        'Search Document',
                        style: textColor9,
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                        borderRadius: getBorderRadiusWidget(context, 0.08),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const SecondScreen(),
                              ),
                            );
                          },
                          child: Hero(
                            tag: 'pic',
                            child: Image.asset(
                              "assets/images/pic1.jpg",
                              width: width * 0.9,
                              height: 280,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    Positioned(
                      bottom: 0,
                      child: Container(
                        width: width * 0.9,
                        height: 100,
                        padding: EdgeInsets.all(width * 0.04),
                        decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                Colors.transparent,
                                primaryColor,
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                            borderRadius: getBorderRadiusWidget(context, 0.08)),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  'Aadhaar Update',
                                  style: textColor6,
                                ),
                                // SizedBox(height: 10),
                                // Row(
                                //   children: [
                                //     Icon(
                                //       Icons.location_on_sharp,
                                //       size: 24,
                                //       color: backGroundColor,
                                //     ),
                                //     Text(
                                //       'Pang Mapha, Thailand',
                                //       style: textColor7,
                                //     ),
                                //   ],
                                // ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  'Rs.50/',
                                  style: textColor6,
                                ),
                                Text(
                                  'Update',
                                  style: textColor8,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                    // new
                    Stack(
                      children: [
                        ClipRRect(
                        borderRadius: getBorderRadiusWidget(context, 0.08),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const PanScreen(),
                              ),
                            );
                          },
                          child: Hero(
                            tag: 'pic',
                            child: Image.asset(
                              "assets/images/pan.jpg",
                              width: width * 0.9,
                              height: 280,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    Positioned(
                      bottom: 0,
                      child: Container(
                        width: width * 0.9,
                        height: 100,
                        padding: EdgeInsets.all(width * 0.04),
                        decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                Colors.transparent,
                                primaryColor,
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                            borderRadius: getBorderRadiusWidget(context, 0.08)),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  'Pan card Update',
                                  style: textColor6,
                                ),
                                // SizedBox(height: 10),
                                // Row(
                                //   children: [
                                //     Icon(
                                //       Icons.location_on_sharp,
                                //       size: 24,
                                //       color: backGroundColor,
                                //     ),
                                //     Text(
                                //       'Pang Mapha, Thailand',
                                //       style: textColor7,
                                //     ),
                                //   ],
                                // ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  'Rs.50/',
                                  style: textColor6,
                                ),
                                Text(
                                  'Update',
                                  style: textColor8,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    ],
                  ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
