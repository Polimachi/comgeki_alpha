

import 'bullet.dart';

const chart = 
 [[0, 1],
  [2, 0],
  [5, 1],
  [7, 1],
  [5, 0],
  [6, 1],
  [6, 1]];

void executePattern(step , world) {
  if (chart[step][1] == 1) {
    generateBullet(0, 0, 500, 0, 0, world);
  }
}