// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Color(0xFF193DB0),
        title: Text(
          "About us",
          style: TextStyle(
            fontSize: 22,
            color: Colors.white,
            fontFamily: "English",
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          ListTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "HELP",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            fontFamily: "English",
                          ),
                        ),
                        SizedBox(height: 15),
                        Text(
                          "Contact us \nReturns and Changes \nShipping & Delivery \nOrder Tracking \nFAQ",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontFamily: "English",
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "ABOUT US",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            fontFamily: "English",
                          ),
                        ),
                        SizedBox(height: 15),
                        Text(
                          "About us \nOur Stores \nCorporate\nCareer Opportunities \nCorporate Support ",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontFamily: "English",
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    Text(
                      "POLICIES",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        fontFamily: "English",
                      ),
                    ),
                    SizedBox(height: 15),
                    Text(
                      "Data Privacy And \nSecurity Policy \nTerms Of use",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontFamily: "English",
                      ),
                    ),
                  ],
                ),
              ],
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 90),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 50),
                  Text(
                    "V",
                    style: TextStyle(
                      fontFamily: "English",
                      fontSize: 80,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 19, 24, 33),
                    ),
                  ),
                  Text(
                    "OI",
                    style: TextStyle(
                      fontFamily: "English",
                      fontSize: 80,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  Text(
                    "D",
                    style: TextStyle(
                      fontFamily: "English",
                      fontSize: 80,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 19, 24, 33),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
