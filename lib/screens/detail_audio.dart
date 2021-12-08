import 'package:my_first_app/admob_helper.dart';
import 'package:my_first_app/colors' as AppColors;
import 'package:flutter/material.dart';
import 'package:my_first_app/music_class.dart';
import 'package:my_first_app/colors' as AppColors;
import 'package:audioplayers/audioplayers.dart';
import 'package:my_first_app/widgets/audio_file.dart';



class DetaiAudioPage extends StatefulWidget {

  final musicsData;
  final int index;
  const DetaiAudioPage({ Key? key,this.musicsData, required this.index }) : super(key: key);

  @override
  _DetaiAudioPageState createState() => _DetaiAudioPageState();
}

class _DetaiAudioPageState extends State<DetaiAudioPage> {
  var bgColor = AppColors.audioGradienColor;
  var iconHoverColor= Colors.teal[200];
  late AudioPlayer AdvancedPlayer;

  @override
  void initState(){
    super.initState();
    AdvancedPlayer = AudioPlayer();
  }

  @override
  Widget build(BuildContext context) {
    AdmobHelper admobHelper =new AdmobHelper();

    @override
    void initState(){
      super.initState();
      admobHelper.adAds(true,true);
    }
     final double ScreenHeight = MediaQuery.of(context).size.height;
    final double Screenwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      
      backgroundColor: AppColors.audioBleushBackground,
      body: Stack(
        children: [
         Positioned(
           top: 0,
           left: 0,
           right: 0,
           child: Container(
             color: AppColors.audioBleushBackground,
           ),
         ),
         Positioned(
           top: 0,
           right: 0,
           left: 0,
           child: AppBar(
             backgroundColor: Colors.transparent,
             elevation: 0,
             leading: IconButton(
               onPressed: (){
                 Navigator.of(context).pop();
                 AdvancedPlayer.stop();
               },
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ))
             ),
           ),
           Positioned(
             left: 0,
             right: 0,
             top: ScreenHeight*0.1,
             height: ScreenHeight,
             child: Container(
               decoration: BoxDecoration(
                 borderRadius: BorderRadius.only(topLeft:Radius.circular(70)),
                 color:Colors.orange,
               ),
              child: Center(
                child: Column(
                  children: [
                    Container(
                      height: 800.0,
                      decoration: BoxDecoration(
                     borderRadius: BorderRadius.only(topLeft:Radius.circular(70)),
                      ),
                      child:Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(topLeft:Radius.circular(70)),
                              image: DecorationImage(
                                image:NetworkImage(this.widget.musicsData[this.widget.index]['image']),
                                fit:BoxFit.cover,
                                 ) 
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(topLeft:Radius.circular(70)),
                              gradient: LinearGradient(
                                end: Alignment.bottomCenter,
                                begin:Alignment.topCenter ,
                                colors:[bgColor.withOpacity(0.5),bgColor] ,
                              )
                            ),
                          ),
                          Positioned(
                            top:ScreenHeight*0.56,
                            left:0,
                            right:0,
                            height: ScreenHeight * 0.4,
                            child:Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(26),
                                //color: Colors.white.withOpacity(0.9)                         
                              ),
                              child: Column(
                                children: [
                                  Text(
                                  this.widget.musicsData[this.widget.index]["title"],
                                  style: TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                  ),
                                  SizedBox(height: 4.0,),
                                Text(
                                  this.widget.musicsData[this.widget.index]["singer"],
                                  style:TextStyle(
                                    color: Colors.black.withOpacity(0.6),
                                    fontSize: 18,
                                  )
                                ),
                                audioFile(AdvancedPlayer: AdvancedPlayer, audioPath: this.widget.musicsData[this.widget.index]['url'])
                                ],
                              ),
                            )
                          
                          )
                        ],
                      )
                      ),

                    
                  ],
                ),
              ),
             ),
           ),
         
      ],),
      
    );
  }
}