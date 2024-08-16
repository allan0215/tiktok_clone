import 'package:flutter/material.dart';
import 'package:tiktok_clone/practice/music_notation/basic_classes.dart';
import 'package:tiktok_clone/practice/music_notation/music_notation_paths.dart';

class NotePaint extends StatelessWidget {
  final NoteLength noteLength;
  final double spaceHeight;
  double get _noteWidth => spaceHeight / 0.8108727689536598;
  Size get _tailBoxSize {
    if (noteLength == NoteLength.eigth) {
      return Size((spaceHeight * 4) / 2.864541098415039, (spaceHeight * 4));
    } else {
      return const Size(0, 0);
    }
  }

  Size get _totalBoxSize =>
      Size(spaceHeight * 4.5, _noteWidth + _tailBoxSize.width);
  _headType(NoteLength length) {
    if (length == NoteLength.whole) {
      return HeadType.whole;
    } else if (length == NoteLength.second) {
      return HeadType.white;
    } else {
      return HeadType.black;
    }
  }

  const NotePaint({
    super.key,
    required this.noteLength,
    required this.spaceHeight,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: spaceHeight * 4.5,
      width: _noteWidth + _tailBoxSize.width,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            child: CustomPaint(
              // note stem part
              painter: StemPainter(),
              child: Container(
                alignment: Alignment.bottomCenter,
                width: _noteWidth,
                height: spaceHeight * 4.5,
                child: CustomPaint(
                  // note head part
                  size: Size(_noteWidth, spaceHeight),
                  painter: HeadPainter(headType: _headType(noteLength)),
                ),
              ),
            ),
          ),
          if (noteLength == NoteLength.eigth)
            Positioned(
              right: spaceHeight * 9 / 80,
              child: SizedBox(
                height: _tailBoxSize.height,
                width: _tailBoxSize.width,
                child: CustomPaint(
                  painter: TailPainter(),
                ),
              ),
            )
        ],
      ),
    );
  }
}

class TailPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    canvas.drawPath(MusicNotationPath.singleTail(size), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class StemPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..strokeWidth = size.height * 2.5 / 80
      ..style = PaintingStyle.stroke
      ..color = Colors.black;

    final Path path = Path()
      ..moveTo(size.width - size.height * 1.25 / 80, size.height * 0.850)
      ..lineTo(size.width - size.height * 1.25 / 80, 0);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class HeadPainter extends CustomPainter {
  final HeadType headType;
  Path headPath({required HeadType headType, required Size size}) {
    if (headType == HeadType.black) {
      return MusicNotationPath.blackHead(size);
    } else {
      return Path();
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.black;
    canvas.drawPath(headPath(headType: headType, size: size), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

  const HeadPainter({required this.headType});
}
