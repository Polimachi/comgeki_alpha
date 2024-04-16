library;

import 'dart:async';
import 'dart:math' as math;

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/debug.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/palette.dart';
import 'package:flame/timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

import 'package:time/time.dart';

import 'bullet.dart';

void main() {
  runApp(const GameApp());
}

class GameApp extends StatefulWidget {
  const GameApp({super.key});

  @override
  State<GameApp> createState() => _GameAppState();
}

class _GameAppState extends State<GameApp> {
  late final PlayModule game;

  @override
  void initState() {
    super.initState();
    game = PlayModule();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromARGB(255, 0, 125, 167),
                Color.fromARGB(255, 0, 0, 0),
              ],
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Center(
                child: FittedBox(
                  child: SizedBox(
                    width: gameWidth,
                    height: gameHeight,
                    child: GameWidget(
                      game: game,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PlayModule extends FlameGame
    with MouseMovementDetector, KeyboardEvents {

  Timer interval = Timer(1,);
  int elapsedSeconds = 0;

  @override
  FutureOr<void> onLoad() {
    super.onLoad();
    camera.viewfinder.anchor = Anchor.topLeft;
    world.add(PlayArea());
    world.add(TimeTrackComponent());

    startGame();
  }
  
  void startGame() async{
    generateBullet(0, 0, 500, 0, 0, world);
    generateCircularPattern(0, 0, 1000, 30, -1, 30, 0.015, 0, world);

    world.add(TimerComponent( period: 0.25,
                                repeat:  true,
                                onTick: () => generateBullet(-100, 0, 500, 0, 0, world)
                                ));
    world.add(TimerComponent( period: 2,
                                repeat:  true,
                                onTick: () => generateBullet(100, 0, 500, 0, 0, world)
                                ));

    int bpm = 180;
    double tick = 1 / ( bpm / 60 );

    world.add(TimerComponent( period: tick,
                                repeat:  true,
                                onTick: () => generateBullet(0, 0, 500, 0, 0, world)
                                ));

  }

  @override
  KeyEventResult onKeyEvent(
    KeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    super.onKeyEvent(event, keysPressed);
    switch (event.logicalKey) {
      case LogicalKeyboardKey.space:
        startGame();
    }
    return KeyEventResult.handled;
  }
}

class PlayArea extends RectangleComponent {
  PlayArea() : super(children: [RectangleHitbox()]);

  @override
  Future<void> onLoad() async {
    super.onLoad();
    size = Vector2(width, height);

  }
}

const predefinedColors = [
  Color(0xfff94144),
  Color(0xfff3722c),
  Color(0xfff8961e),
  Color(0xfff9844a),
  Color(0xfff9c74f),
  Color(0xff90be6d),
  Color(0xff43aa8b),
  Color(0xff4d908e),
  Color(0xff277da1),
  Color(0xff577590),
];

const gameWidth = 840.0;
double width = gameWidth;
const gameHeight = 1600.0;
double height = gameHeight;
const scrollSpeed = 1.0;
const bpm = 180;

