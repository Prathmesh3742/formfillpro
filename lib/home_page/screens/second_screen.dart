import 'package:flutter/material.dart';
import 'package:formfillpro/home_page/screens/DocumentUploadForm.dart';
import 'package:formfillpro/home_page/screens/first_screen.dart';
import 'package:formfillpro/home_page/tools/border.dart';
import 'package:formfillpro/home_page/tools/colors.dart';

import '../tools/text_style.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    String desc =
        'Addres, Gender, Name and mobile number can be updated. For biometrics need to visit aadhaar centre';
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
                                "assets/images/pic1.jpg",
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
                                      'Aadhar Card',
                                      style: textColor5,
                                    ),
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
                    name: 'Name Update',
                    documentsRequired: ['Identity Proof','Bank Passbook'],
                    uploadFormFields: ['Identity Proof','Bank Passbook'],
                  ),
                  const UpdateOption(
                    name: 'Address Update',
                    documentsRequired: ['Proof of Address','Any gov document'],
                    uploadFormFields: ['Proof of Address','Any gov document'],
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

class UpdateOption extends StatefulWidget {
  final String name;
  final List<String> documentsRequired;
  final List<String> uploadFormFields; // New parameter

  const UpdateOption({
    Key? key,
    required this.name,
    required this.documentsRequired,
    required this.uploadFormFields, // New parameter
  }) : super(key: key);

  @override
  _UpdateOptionState createState() => _UpdateOptionState();
}


class _UpdateOptionState extends State<UpdateOption> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                widget.name,
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 18,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  expanded = !expanded;
                });
              },
              child: Icon(
                expanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                size: 24,
              ),
            ),
          ],
        ),
        const SizedBox(height: 3),
        if (expanded) ...[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Documents Required:",
                style: TextStyle(
                  color: greyColor,
                  fontFamily: 'medium',
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: widget.documentsRequired
                    .map(
                      (document) => Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Row(
                          children: [
                            const Icon(Icons.fiber_manual_record, size: 10),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                document,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: greyColor,
                                  fontFamily: 'medium',
                                  fontWeight: FontWeight.w600,
                                  height: 1.3,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(height: 10),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DocumentUploadForm(
                          fieldNames: widget.uploadFormFields,
                          headerTitle: widget.name
                        ),
                      ),
                    );
                  },
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.green),
                  ),
                  child: const Text('Apply'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
        ],
        const SizedBox(height: 4),
      ],
    );
  }
}
