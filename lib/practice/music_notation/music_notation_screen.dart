import 'package:flutter/material.dart';
import 'package:tiktok_clone/practice/music_notation/basic_classes.dart';
import 'package:tiktok_clone/practice/music_notation/music_notation_paths.dart';
import 'package:tiktok_clone/practice/music_notation/widgets/note_painter.dart';

class SVGScreen extends StatelessWidget {
  const SVGScreen({super.key});

  final String fClef = "assets/images/svg/f_clef.svg";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
              width: .5,
            ),
          ),
          height: 400,
          width: 400,
          child: Stack(
            alignment: AlignmentDirectional.centerStart,
            clipBehavior: Clip.none,
            children: [
              const Positioned(
                top: 0,
                left: 50,
                child: NotePaint(
                  noteLength: NoteLength.fourth,
                  spaceHeight: 20,
                ),
              ),
              Positioned(
                child: CustomPaint(
                  size: const Size(400, 100),
                  painter: StaffPainter(),
                ),
              ),
              Positioned(
                child: CustomPaint(
                  painter: GClefPainter(),
                  size: const Size(50, (50 * 2.772935207518922)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GClefPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    canvas.drawPath(MusicNotationPath.gClef(size), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class StaffPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..strokeWidth = 2
      ..color = Colors.black
      ..style = PaintingStyle.stroke;

    final Path staff = Path()
      ..moveTo(0, size.height / 10)
      ..lineTo(size.width, size.height / 10)
      ..moveTo(0, size.height / 10 * 3)
      ..lineTo(size.width, size.height / 10 * 3)
      ..moveTo(0, size.height / 10 * 5)
      ..lineTo(size.width, size.height / 10 * 5)
      ..moveTo(0, size.height / 10 * 7)
      ..lineTo(size.width, size.height / 10 * 7)
      ..moveTo(0, size.height / 10 * 9)
      ..lineTo(size.width, size.height / 10 * 9);

    canvas.drawPath(staff, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
