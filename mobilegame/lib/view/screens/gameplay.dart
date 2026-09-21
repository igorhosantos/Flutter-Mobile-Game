import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Gameplay extends FlameGame{

  @override
  Color backgroundColor () => Colors.transparent;

  @override 
  void onMount() {
    spawnComponents();
    super.onMount();
  }

  void spawnComponents(){
    add(CircleComponent());
  }
}