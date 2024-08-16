import 'dart:io';
import 'dart:typed_data';

final note60 = _getAudioContent();

Future<Uint8List> _getAudioContent() async {
  const path = 'assets/sounds/piano_notes/note62.wav';
  return File('assets/sounds/piano_notes/note62.wav').readAsBytesSync();
}
