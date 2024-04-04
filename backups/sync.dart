
import 'dart:async';
import 'dart:math' as math;
import 'dart:io';

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

import '../lib/bullet.dart';
import '../lib/main.dart';

class Sync {
  //AudioSource

  num musicBpm = 120;
  num stdBpm = 120;
  final minute = 60;
  num musicTempo = 4;
  num stdTempo =4;

  num tickTime = 0;
  num nextTime = 0;

  void start() //being called before start.
  {
    //playTick = get
  }
  
  void update() //being called each frame.
  {
    //play Sounds
    tickTime = (stdBpm / musicBpm) * (musicTempo / stdTempo);

    if(nextTime > tickTime)
    {
      nextTime = 0;
    }
  }

  void playTick(num tickTime) 
  {
    generateBullet(0, 0, 500, 0, 0, 'world');
  }
}