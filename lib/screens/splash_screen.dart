import 'dart:async';
import 'package:flutter/material.dart';
import 'package:my_first_app/colors' as AppColors;
import 'package:my_first_app/screens/home_page.dart';

 class SplashScreen extends StatefulWidget {
   const SplashScreen({ Key? key }) : super(key: key);
 
   @override
   _SplashScreenState createState() => _SplashScreenState();
 }
 
 class _SplashScreenState extends State<SplashScreen> {
   @override
   void initState(){
     super.initState();
     Timer(Duration(seconds: 3),
           ()=> Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MyHomePage()))
             );
   }
   @override
   Widget build(BuildContext context) {
     final double ScreenHeight = MediaQuery.of(context).size.height;
    final double Screenwidth = MediaQuery.of(context).size.width;
     return Scaffold(
       body: Container(
         height: double.infinity,
         width: double.infinity,
         decoration: BoxDecoration(
           gradient: LinearGradient(
             begin: Alignment.topRight,
             end: Alignment.bottomLeft,
             colors: [Color(0xFFFF800B),Color(0xFFCE1010),])
         ),
         child: Stack(
           children: [
              Positioned(
                   left: (Screenwidth - 200) / 2,
                   right: (Screenwidth - 200) / 2,
                   top:ScreenHeight * 0.12, 
                   height: ScreenHeight * 0.2,
                   child: Container(
                     decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(20),
                       color: AppColors.audioGreyBackground,
                     ),
                     child: Padding(
                       padding:EdgeInsets.all(20),
                       child: Container(
                         decoration: BoxDecoration(
                           shape: BoxShape.circle,
                          border: Border.all(color: Colors.white),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage('assets/images/icon.jpg'),
                          )
                         ),
                       ),
                     ),
                     )
                 ),
              Positioned(
                 left: (Screenwidth - 200) / 2,
                 right: (Screenwidth - 200) / 2,
                 top:ScreenHeight * 0.55, 
               child: Text(
                 'Play and Enjoy \n Top Music Player',
                 textAlign: TextAlign.center,
                 style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 30.0,
                 ),
             
                 ),
             ),
                Positioned(
                left: 200,
                 right: 200,
                 top:ScreenHeight * 0.9, 
                 child: CircularProgressIndicator(
                   valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
                 ),
               ),

           ],
         )
       ),
     );
   }
 }