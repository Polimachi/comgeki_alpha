import 'dart:async';
import 'dart:math' as math;
import 'dart:io';

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

void generateBullet(
    double initPositionX,
    double initPositionY,
    num velocity,
    num theta,
    int type,
    world) {

  double thetaTransformed = theta * math.pi / 180;

  if (type == 0) //circleBullet
  {
    world.add(circleBullet(
      velocity: 
        Vector2(velocity * math.sin(thetaTransformed), velocity * math.cos(thetaTransformed)),
      position:
        Vector2(initPositionX + 420, initPositionY),
      radius: 15));
  }
}

void generateCircularPattern(
    double initPositionX,
    double initPositionY,
    num velocity,
    num initAngle,
    num iterAngle,
    int count,
    double iterDelay,
    int type,
    world) {
    
    generateBullet( initPositionX,
                    initPositionY,
                    velocity,
                    initAngle + iterAngle,
                    type,
                    world);

    if (count>0) {
      world.add(TimerComponent( period: iterDelay,
                                repeat:  false,
                                onTick: () => generateCircularPattern(
                                  initPositionX,
                                  initPositionY,
                                  velocity,
                                  initAngle + iterAngle,
                                  iterAngle,
                                  count - 1,
                                  iterDelay,
                                  type,
                                  world
                                )));
    }
}

void generatePattern(int patternType, Set components) {
  if (patternType == 0) // Circular
  {
    //generateCircularPattern();
  }
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