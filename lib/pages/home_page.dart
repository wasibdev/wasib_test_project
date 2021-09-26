import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_project/pages/albums_page.dart';
import 'package:test_project/pages/posts_page.dart';
import 'package:test_project/utils/values.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: bg2Color,
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: width/1.5,
                width: width/1.5,
                child:
                Image.asset("assets/images/home_2.png"),
              ),
              const SizedBox(height: 16,),
              Text(
                welcome,
                style: GoogleFonts.nunitoSans(
                  height: 1,
                  color: text1Color,
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 8,),
              SizedBox(
                width: width/1.2,
                child: Text(
                  info,
                  style: GoogleFonts.nunitoSans(
                    color: text1Color,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 64,),
              button(context, homeButton1, const AlbumPage()),
              button(context, homeButton2, const PostPage()),
            ],
          ),
        ),
      ),
    );
  }

  Widget button(context,text, route){
    return Container(
      width: 250,
      margin: const EdgeInsets.all(8),
      child: TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => route),
            );
          },
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  )
              )
          ),
          child: Container(
            padding: const EdgeInsets.only(left: 16,right: 16,top: 12,bottom: 12),
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: GoogleFonts.nunitoSans(
                height: 1,
                color: text1Color,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          )
      ),
    );
  }
}