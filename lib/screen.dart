// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:luminious/constants/constraint.dart';
import 'package:luminious/constants/theme.dart';
import 'package:provider/provider.dart';

class Screen extends StatefulWidget {
  const Screen({super.key});

  @override
  State<Screen> createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  Offset intialPosition = const Offset(250, 0);
  Offset switchPosition = const Offset(350, 350);
  Offset containerPosition = const Offset(350, 350);
  Offset finalPosition = const Offset(350, 350);

  @override
  void didChangeDependencies() {
    final Size size = MediaQuery.of(context).size;
    final ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);

    intialPosition = Offset(size.width * .9, 0);
    containerPosition = Offset(size.width * .9, size.height * .4);
    finalPosition = Offset(size.width * .9, size.height * .5 - size.width * .1);

    if (themeProvider.isLightTheme) {
      switchPosition = containerPosition;
    } else {
      switchPosition = finalPosition;
    }
 
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: RadialGradient(
          center: const Alignment(-0.8, -0.3),
          radius: 1,
          colors: themeProvider.themeMode().gradientColors!,
        )),
        child: Stack(
          fit: StackFit.expand,
          children: [
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                    DateFormat('H').format(DateTime.now()),
                      
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    SizedBox(
                      width: size.width * .2,
                      child: Divider(
                        color: AppColors.white,
                        thickness: 2.5,
                        height: 0,
                      ),
                    ),
                    Text(
                     DateTime.now().minute.toString(),
                      
                        style: Theme.of(context)
                            .textTheme
                            .headlineLarge
                            ?.copyWith(color: AppColors.white)),
                    Spacer(
                      flex: 6,
                    ),
                    Text(
                      'Light & Dark\nTheme\nSwitch',
                        style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            height: 1.1)),
                    Spacer(
                      flex: 5,
                    ),
                    Container(
                      width: size.width * .26,
                      height: size.height * .1,
                      decoration: BoxDecoration(
                        color: themeProvider.themeMode().switchColor,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Icon(
                        Icons.nights_stay_outlined,
                        color: AppColors.white,
                        size: 60,
                      ),
                    ),
                    SizedBox(
                      width: size.width * .25,
                      child: Divider(
                        color: AppColors.white,
                        thickness: 2.5,
                        height: 15,
                      ),
                    ),
                    Text(
                      '30\u00B0C',
                      style: Theme.of(context)
                          .textTheme
                          .displayLarge
                          ?.copyWith(color: AppColors.white),
                    ),
                    Text(
                      'clear',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    Text(DateFormat('EEEE').format(DateTime.now()),
                        style: Theme.of(context).textTheme.headlineSmall),
                    Text(DateFormat('MMM d').format(DateTime.now()),
                        style: Theme.of(context).textTheme.headlineSmall),
                    Spacer()
                  ],
                ),
              ),
            ),
            Positioned(
              top: containerPosition.dy - size.width * .1 / 2 - 5,
              left: containerPosition.dx - size.width * .1 / 2 - 5,
              child: Container(
                width: size.width * .1 + 10,
                height: size.height * .09 + 10,
                decoration: BoxDecoration(
                    color: themeProvider.themeMode().switchBgColor!,
                    borderRadius: BorderRadius.circular(20)),
              ),
            ),
            Wire(
              intialPosition: intialPosition,
              toOffset: switchPosition,
            ),
            AnimatedPositioned(
              duration: Duration(milliseconds: 0),
              top: switchPosition.dy - size.width * 0.1 / 2,
              left: switchPosition.dx - size.width * 0.1 / 2,
              child: Draggable(
                feedback: Container(
                    width: size.width * .1,
                    height: size.width * .1,
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        shape: BoxShape.circle,
                        border: Border.all(
                          width: 5,
                          color: Colors.transparent,
                        ))),
                onDragEnd: (details) {
                  if (themeProvider.isLightTheme) {
                    setState(() {
                      switchPosition = containerPosition;
                    });
                  } else {
                    (setState(() {
                      switchPosition = finalPosition;
                    }));
                  }

                  themeProvider.toogleThemeData();
                },
                onDragUpdate: (details) {
                  setState(() {
                    switchPosition = details.localPosition;
                  });
                },
                child: Container(
                  width: size.width * .1,
                  height: size.width * .1,
                  decoration: BoxDecoration(
                      color: themeProvider.themeMode().thumbColor,
                      shape: BoxShape.circle,
                      border: Border.all(
                        width: 5,
                        color: themeProvider.themeMode().switchColor!,
                      )),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Wire extends StatefulWidget {
  const Wire({super.key, required this.intialPosition, required this.toOffset});
  final Offset intialPosition;
  final Offset toOffset;

  @override
  State<Wire> createState() => _WireState();
}

class _WireState extends State<Wire> {
  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    return CustomPaint(
        painter: WirePainter(
            intialPosition: widget.intialPosition,
            toOffset: widget.toOffset,
            themeProvider: themeProvider));
  }
}

class WirePainter extends CustomPainter {
  final Offset intialPosition;
  final Offset toOffset;
  final ThemeProvider themeProvider;

  Paint? _paint;

  WirePainter(
      {required this.intialPosition,
      required this.toOffset,
      required this.themeProvider});

  @override
  void paint(Canvas canvas, Size size) {
    _paint = Paint()
      ..color = themeProvider.themeMode().switchColor!
      ..strokeWidth = 10
      ..style = PaintingStyle.stroke;

    canvas.drawLine(intialPosition, toOffset, _paint!);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
