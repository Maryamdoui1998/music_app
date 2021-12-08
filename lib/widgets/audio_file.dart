import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';


class audioFile extends StatefulWidget {
  final AudioPlayer AdvancedPlayer;
  final String audioPath;

  const audioFile({Key? key, required this.AdvancedPlayer, required this.audioPath}) : super(key: key);

  @override
  _audioFileState createState() => _audioFileState();
}

class _audioFileState extends State<audioFile> {

  Duration _duration = new Duration();
  Duration _position = new Duration();
  final AdvancedPlayer= new AudioPlayer(mode: PlayerMode.MEDIA_PLAYER);
  bool isPaused = false;
  bool isPlaying=false;
  bool isRepeat = false;
  String currentSong = "";
  Color color= Colors.black;
  List<IconData> _Icons = [
    Icons.play_circle_fill,
    Icons.pause_circle_filled,
  ];

void playMusic (String url)async{
  if(isPlaying && currentSong !=(url)){
    AdvancedPlayer.pause();
    int result =await AdvancedPlayer.play(url);
    if(result==1){
      setState(() {
        currentSong=url;
      });
    }
  }else if(!isPlaying){
    int result = await AdvancedPlayer.play(url);
    if(result==1){
      setState(() {
        isPlaying=true;
      });
    }
  }
}
  @override
  void initState(){
    super.initState();
    this.widget.AdvancedPlayer.onDurationChanged.listen((d) {
      setState(() {
        _duration=d;
      });
    });
    this.widget.AdvancedPlayer.onAudioPositionChanged.listen((p) {
      setState(() {
        _position=p;
      });
     });
     this.widget.AdvancedPlayer.setUrl(this.widget.audioPath);
     this.widget.AdvancedPlayer.onPlayerCompletion.listen((event) {
       setState(() {
         _position= Duration(seconds: 0);
         if(isRepeat==true){
           isPlaying=true;
         }else{
           isPlaying=false;
           isRepeat=false;
         }
       });
     });
  } 
  Widget btnStar(){
    return IconButton(
      padding: const EdgeInsets.only(bottom: 10),
      icon: isPlaying==false?Icon(_Icons[0],size: 50,color: Colors.blue,):Icon(_Icons[1],size: 50,color: Colors.blue,),
      onPressed:(){
        if(isPlaying==false){
          this.widget.AdvancedPlayer.play(this.widget.audioPath);
          setState(() {
            isPlaying=true;

          });

        }else if(isPlaying==true){
          this.widget.AdvancedPlayer.pause();
          setState(() {
            isPlaying=false;
          });

        }
      }
    );
  }

  Widget btnRepeat(){
    return IconButton(
      icon: Icon(
        Icons.repeat,
        size: 30,
        color: color,
      ),
      onPressed: (){
        if(isRepeat==false){
          this.widget.AdvancedPlayer.setReleaseMode(ReleaseMode.LOOP);
          setState(() {
            isRepeat=true;
            color=Colors.blue;
          });

        } else if (isRepeat==true){
          this.widget.AdvancedPlayer.setReleaseMode(ReleaseMode.RELEASE);
          setState(() {
            isRepeat=false;
            color=Colors.black;
          });

        }    
         },
    );
  }

Widget bntFast(){
  return IconButton(
    icon: Icon(
      Icons.fast_forward,
      size: 30,
      color:Colors.black,
    ),
    onPressed: (){
      this.widget.AdvancedPlayer.setPlaybackRate(playbackRate: 1.5);
    },
  );
}
Widget btnSlow(){
 return IconButton(
   onPressed: (){
     this.widget.AdvancedPlayer.setPlaybackRate(playbackRate: 0.5);
   },
   icon: Icon(
     Icons.fast_rewind,
     size: 30,
     color: Colors.black,
   )
   );
}

Widget btnLoop(){
 return IconButton(
   onPressed: (){
     setState(() {
       color= Colors.blue;
     });
   },
   icon: Icon(
     Icons.loop,
     size: 30,
     color: color,
   )
   );
}

Widget loadAssets(){
  return Container(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        btnRepeat(),
        btnSlow(),
        btnStar(),
        bntFast(),
        btnLoop(),
      ],
      ),
  );
}
Widget slider(){
  return Slider(
    activeColor: Colors.blue,
    inactiveColor: Colors.black, 
    min: 0.0,
    value: _position.inSeconds.toDouble(),
    max: _duration.inSeconds.toDouble(),
    onChanged: (double value){
      setState(() {
        changeToSecond(value.toInt());
        value= value;
      });
    }
    );
}
 void changeToSecond(int second){
    Duration newDuration =Duration(seconds: second);
    this.widget.AdvancedPlayer.seek(newDuration);
 }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 5, right: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _position.toString().split('.')[0],
                  style: TextStyle(
                    color:Colors.black,
                    fontSize: 16,
                  ),
                ),
               Text(
                  _duration.toString().split('.')[0],
                  style: TextStyle(
                    color:Colors.black,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          slider(),
          loadAssets(),
        ],
      ),
    );
  }
}