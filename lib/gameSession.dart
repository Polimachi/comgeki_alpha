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
import 'package:metronome/metronome.dart';

import 'bullet.dart';


class SessionInGame extends FlameGame
    with MouseMovementDetector, KeyboardEvents {

  @override
  FutureOr<void> onLoad() async {
    super.onLoad();
    camera.viewfinder.anchor = Anchor.topLeft;
    world.add(PlayArea());
    world.add(TimeTrackComponent());

    startGame();
  }
  
  void startGame() {
      // call Metronome
      final _tempMetronome = Metronome();
      int bpm = 180;

      _tempMetronome.init('', bpm: bpm, volume: 0);
      _tempMetronome.onListenTick((_) {
        
      });

      // play Music
      
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
    print(keysPressed);
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