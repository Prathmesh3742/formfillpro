import 'package:flutter/material.dart';
import 'package:formfillpro/home_page/screens/DocumentUploadForm.dart';
import 'package:formfillpro/home_page/screens/first_screen.dart';
import 'package:formfillpro/home_page/screens/second_screen.dart';
import 'package:formfillpro/home_page/tools/border.dart';
import 'package:formfillpro/home_page/tools/colors.dart';

import '../tools/text_style.dart';

class PanScreen extends StatelessWidget {
  const PanScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    String desc =
        'Address, Gender, Name, and mobile number can be updated.';
    return Container(
      color: greyColor,
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.03,
                vertical: 25,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: searchBarColor,
                          blurRadius: 15,
                          offset: Offset(10, 10),
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const FirstScreen(),
                              ),
                            );
                          },
                          child: ClipRRect(
                            borderRadius: getBorderRadiusWidget(context, 0.08),
                            child: Hero(
                              tag: 'pic',
                              child: Image.asset(
                                "assets/images/pan.jpg",
                                width: width,
                                height: 400,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: width,
                          margin: EdgeInsets.symmetric(
                              horizontal: width * 0.04, vertical: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: (){
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  padding: EdgeInsets.all(width * 0.03),
                                  decoration: BoxDecoration(
                                    color: Colors.black38,
                                    borderRadius:
                                        getBorderRadiusWidget(context, 0.03),
                                  ),
                                  child: const Icon(
                                    Icons.arrow_back_ios_rounded,
                                    color: backGroundColor,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(width * 0.03),
                                decoration: BoxDecoration(
                                  color: Colors.black38,
                                  borderRadius:
                                      getBorderRadiusWidget(context, 0.03),
                                ),
                                child: const Icon(
                                  Icons.favorite_border_rounded,
                                  color: backGroundColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          child: Container(
                            width: width * 0.95,
                            height: 120,
                            padding: EdgeInsets.symmetric(
                              horizontal: width * 0.04,
                              vertical: 20,
                            ),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [
                                  Colors.transparent,
                                  primaryColor,
                                ],
                                end: Alignment.bottomCenter,
                                begin: Alignment.topCenter,
                              ),
                              borderRadius:
                                  getBorderRadiusWidget(context, 0.08),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      'Pan Card',
                                      style: textColor5,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Rs.100/',
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
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Description',
                    style: textColor2,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    desc,
                    style: textColor11,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Updates',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Update options
                  const UpdateOption(
                    documentName: 'Pan card',
                    updateName: 'Name Update',
                    documentsRequired: ['Identity Proof','Bank Passbook'],
                  ),
                  const UpdateOption(
                    documentName: 'Pan card',
                    updateName: 'Address Update',
                    documentsRequired: ['Proof of Address','Any gov document'],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
