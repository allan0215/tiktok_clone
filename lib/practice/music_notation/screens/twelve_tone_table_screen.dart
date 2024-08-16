// import 'dart:io';

// import 'package:audioplayers/audioplayers.dart';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:tiktok_clone/practice/music_notation/utils/audio_bytes_array.dart';
// import 'package:tiktok_clone/practice/music_notation/utils/note.dart';
// import 'package:tiktok_clone/practice/music_notation/utils/note60.dart';
// import 'package:tiktok_clone/practice/music_notation/utils/twelve_tone.dart';
// import 'package:path_provider/path_provider.dart';

// class TwelveToneScreen extends StatefulWidget {
//   const TwelveToneScreen({super.key});

//   @override
//   State<TwelveToneScreen> createState() => _TwelveToneScreenState();
// }z

// class _TwelveToneScreenState extends State<TwelveToneScreen> {
//   final TwelveTone _twelveTone = TwelveTone(notes: {
//     Solfege.Eb,
//     Solfege.Bb,
//     Solfege.Ab,
//     Solfege.B,
//     Solfege.G,
//     Solfege.Db,
//     Solfege.F,
//     Solfege.C,
//     Solfege.Gb,
//     Solfege.D,
//     Solfege.A,
//     Solfege.E,
//   });

//   final _player = AudioPlayer();
//   final _player1 = AudioPlayer();
//   final _player2 = AudioPlayer();
//   final _player3 = AudioPlayer();
//   final bytePlayer = AudioPlayer();

//   Future<void> _setAudio() async {
// /*     _player.audioCache = AudioCache(prefix: "assets/sounds/piano_notes/");
//     _player1.audioCache = AudioCache(prefix: "assets/sounds/piano_notes/");
//     _player2.audioCache = AudioCache(prefix: "assets/sounds/piano_notes/");
//     _player3.audioCache = AudioCache(prefix: "assets/sounds/piano_notes/"); */
//     AudioCache.instance.prefix = "assets/sounds/piano_notes/";
//     await _player.setSourceAsset("note60.wav");
//     await _player1.setSourceAsset("note64.wav");
//     await _player2.setSourceAsset("note67.wav");
//     await _player3.setSourceAsset("note72.wav");
//     await _player.setPlayerMode(PlayerMode.lowLatency);
//     await _player1.setPlayerMode(PlayerMode.lowLatency);
//     await _player2.setPlayerMode(PlayerMode.lowLatency);
//     await _player3.setPlayerMode(PlayerMode.lowLatency);
//     await _player.setReleaseMode(ReleaseMode.stop);
//     await _player1.setReleaseMode(ReleaseMode.stop);
//     await _player2.setReleaseMode(ReleaseMode.stop);
//     await _player3.setReleaseMode(ReleaseMode.stop);
//   }

//   Future<void> _setByteAssete() async {
//     await bytePlayer.play(BytesSource(note60Byte));
//   }

//   Future<void> _onPlayPressed() async {
//     /* _player.seek(Duration.zero);
//     _player1.seek(Duration.zero);
//     _player2.seek(Duration.zero);
//     _player3.seek(Duration.zero);
//     _player.resume();
//     _player1.resume();
//     _player2.resume();
//     _player3.resume(); */
//     bytePlayer.resume();
//   }

//   @override
//   void initState() {
//     super.initState();
//     _setAudio();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Column(
//           children: [
//             IconButton(
//                 onPressed: _onPlayPressed,
//                 icon: const FaIcon(FontAwesomeIcons.play)),
//             SingleChildScrollView(
//               scrollDirection: Axis.horizontal,
//               child: Center(
//                 child: SizedBox(
//                   width: 700,
//                   height: 700,
//                   child: ListView.builder(
//                     scrollDirection: Axis.vertical,
//                     itemCount: 14,
//                     itemBuilder: (context, index) {
//                       if (index == 0 || index == 13) {
//                         return Row(
//                           children: [
//                             for (var i = 0; i < 14; i++)
//                               Container(
//                                 width: 50,
//                                 height: 50,
//                                 decoration: BoxDecoration(
//                                   border:
//                                       Border.all(width: 1, color: Colors.black),
//                                 ),
//                               ),
//                           ],
//                         );
//                       } else {
//                         return Row(
//                           children: [
//                             for (var i = 0; i < 14; i++)
//                               Container(
//                                 width: 50,
//                                 height: 50,
//                                 decoration: BoxDecoration(
//                                   border:
//                                       Border.all(width: 1, color: Colors.black),
//                                 ),
//                                 child: i == 0 || i == 13
//                                     ? null
//                                     : Text(_twelveTone
//                                         .primary(index - 1)[i - 1]
//                                         .name),
//                               ),
//                           ],
//                         );
//                       }
//                     },
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
