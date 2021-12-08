import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:my_first_app/admob_helper.dart';
import 'package:my_first_app/colors' as AppColors;
import 'package:my_first_app/custum_list_songs.dart';
import 'package:my_first_app/screens/detail_audio.dart';
import 'package:my_first_app/widgets/custom_list.dart';

import '../music_class.dart';


class MyHomePage extends StatefulWidget {
  

   MyHomePage({ Key? key }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List musics=[];
  final AdmobHelper admobHelper= AdmobHelper();
  

    readJson() async{
    await DefaultAssetBundle.of(context).loadString('json/songsdata.json').then((s) {
      setState(() {
        musics =jsonDecode(s);
      });
    });
  }

   
  @override
  void initState(){
    super.initState();
    readJson();
    admobHelper.adAds(true, true);
   
    // _createBottomBannerAd();
  }


  @override
  Widget build(BuildContext context) {
   
    final ScreenWidth =MediaQuery.of(context).size.width;
    final ScreenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Akon Music App',
        ),

      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              
              itemCount: musics==null?0:musics.length,
              itemBuilder: (_, i)=>customListSongs(
                              onTap: (){                    
                                //admobHelper.showInterstitialAd();
                                Navigator.push(
                                  context, 
                                  MaterialPageRoute(
                                    builder: (context)=>DetaiAudioPage(musicsData: musics, index: i,)
                                    )
                                  );
                              },
                              title: musics[i]['title'] ,
                              singer:musics[i]['singer'] ,
                              image:musics[i]['image'] ,
                  
                            )
            ),
          ),
        ],
      ),
      bottomNavigationBar:// _isBottomBannerAdLoaded
       Container(
        alignment: Alignment.bottomCenter,
        child: AdWidget(ad: admobHelper.getBannerAd()! , key: UniqueKey(),),
        height:admobHelper.getBannerAd()?.size.height.toDouble() ,
        width: admobHelper.getBannerAd()?.size.width.toDouble(),
      )
      
    );
  }
}