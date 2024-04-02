import 'dart:async';
import 'dart:math' as math;

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

void generateBullet(double initPositionX, double initPositionY, num theta, num velocity, int type, world) {
  if (type == 0) //circleBullet
  {
    world.add(circleBullet(
      velocity: 
        Vector2((math.Random().nextDouble()-1), 10),
      position:
        Vector2(initPositionX + 840, initPositionY),
      radius: 15));
  }
}

void generatePattern(int patternType, Set<int> components) {

}

class Bullet extends SpriteAnimationComponent
    with CollisionCallbacks {

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    if (other is! Bullet) {
      removeFromParent();
    }
  }
}

class circleBullet extends CircleComponent
    with CollisionCallbacks {
  circleBullet({
    required this.velocity,
    required super.position,
    required double radius,
  }) : super(
            radius: radius,
            anchor: Anchor.center,
            paint: Paint()
              ..color = Color.fromARGB(255, 15, 86, 140)
              ..style = PaintingStyle.fill,
            children: [CircleHitbox()]);

  final Vector2 velocity;

  @override
  void update(double dt) {
    super.update(dt);
    position += velocity * dt;
  }
}

const middlePoint = 840.0;