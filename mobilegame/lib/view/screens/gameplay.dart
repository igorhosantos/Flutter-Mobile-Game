import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/palette.dart';
import 'package:flame/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobilegame/factory/enemy_creator.dart';
import 'package:mobilegame/view/components/player_component.dart';
import 'package:mobilegame/factory/star_background_creator.dart';

class Gameplay extends FlameGame
    with
        DragCallbacks,
        HasCollisionDetection,
        HasPerformanceTracker,
        HasKeyboardHandlerComponents {

  //main game data
  int _score = 0;
  int get score => _score;
  
  bool _isPaused = true;
  bool get isPaused => _isPaused;

  int _life = 5;
  int get life => _life; 

  //exposed callbacks
  late final VoidCallback onGameOver;
  
  //main components
  late final PlayerComponent _player;
  late final TextComponent _componentCounter;
  late final TextComponent _scoreText;
  late final SpriteButtonComponent _pauseButton;
  late final SpriteButtonComponent _saveButton;

  late final TextComponent _gameStatusLabel;

  // Batch groups — one per sprite type for isolated draw-call batching.
  // Each is a plain PositionComponent with HasAutoBatchedChildren mixed in.
  late final BatchGroup bulletGroup;
  late final BatchGroup enemyGroup;
  late final BatchGroup starGroup;
  late final BatchGroup explosionGroup;

  static final _textStyleRed = TextPaint(
    style: TextPaint.defaultTextStyle.copyWith(color: const Color(0xFFFF0000)),
  );

  static final _textStyleGreen = TextPaint(
    style: TextPaint.defaultTextStyle.copyWith(color: const Color(0xFF00FF00)),
  );


  final TextComponent _batchingText = TextComponent(
    position: Vector2(0, 0),
    priority: 1,
    textRenderer: _textStyleRed,
  );
  

  @override
  Future<void> onLoad() async {
    // Add batch groups first so component creators can reference them.
    
    addAll([
      starGroup = BatchGroup(priority: -1),
      bulletGroup = BatchGroup(priority: 0),
      enemyGroup = BatchGroup(priority: 0),
      explosionGroup = BatchGroup(priority: 0),
    ]);

    add(_player = PlayerComponent());

    add(EnemyCreator());
    
    add(StarBackGroundCreator());

    addAll([_batchingText]);
    
    _updateBatchingLabel();

    add(
      KeyboardListenerComponent(
        keyDown: {
          LogicalKeyboardKey.keyB: (_) {
            final enabled = !bulletGroup.batchingEnabled;
            bulletGroup.batchingEnabled = enabled;
            enemyGroup.batchingEnabled = enabled;
            starGroup.batchingEnabled = enabled;
            explosionGroup.batchingEnabled = enabled;
            _updateBatchingLabel();
            return true;
          },
        },
      ),
    );

    final hudComponent = await buildHud();
    addAll(hudComponent);

    startCounting().ignore();
  }

  Future<void> startCounting() async
  {
    final duration  = const Duration(seconds: 1);

    _gameStatusLabel.text = "3";

    await Future.delayed(duration);

    _gameStatusLabel.text = "2";

    await Future.delayed(duration);

    _gameStatusLabel.text = "1";

    await Future.delayed(duration);

    _gameStatusLabel.text = "START!";
    _isPaused = false;

    await Future.delayed(duration);

    _gameStatusLabel.text = '';
    
  }

  Future<Iterable<Component>> buildHud() async
  {
    final pauseSprite = await loadSprite('pause.png');
    final pausePressedSprite = await loadSprite('pause_pressed.png');
    final playSprite = await loadSprite('play.png');
    final playPressedSprite = await loadSprite('play_pressed.png');
    final saveSprite = await loadSprite('save.png');
    final savePressedSprite = await loadSprite('save_pressed.png');


    final menuFontStyle = GoogleFonts.audiowide(
                      fontSize: 55,
                      fontWeight: FontWeight.normal,
                      color: Colors.amber,
    );

    final statusRender = TextPaint(
      style: menuFontStyle,
    );

    return [
       _pauseButton = SpriteButtonComponent(
        button: pauseSprite,
        buttonDown: pausePressedSprite,
        size: Vector2(50, 50),
        onPressed: () {
          _isPaused = !isPaused;
          print('Game Paused clicked! $_isPaused');
          if(_isPaused)
          {
            _pauseButton.button = playSprite;
            _pauseButton.buttonDown = playPressedSprite;
            _gameStatusLabel.text = "PAUSED";
          }
          else{
            _pauseButton.button = pauseSprite;
            _pauseButton.buttonDown = pausePressedSprite;
            _gameStatusLabel.text = "";
          }
         
        },
        position: Vector2(20, size.y - 100),
        priority: 1,
      ),

      _saveButton = SpriteButtonComponent(
        button: saveSprite,
        buttonDown: savePressedSprite,
        size: Vector2(50, 50),
        onPressed: () {
          print('Game Closed clicked!'); 
          onGameOver();
        },
        position: Vector2(20, 50),
        priority: 1,
      ),

      FpsTextComponent(
        position: size - Vector2(0, 50),
        anchor: Anchor.bottomRight,
      ),

      _scoreText = TextComponent(
        position: size - Vector2(0, 25),
        anchor: Anchor.bottomRight,
        priority: 1,
      ),

      _componentCounter = TextComponent(
        position: size,
        anchor: Anchor.bottomRight,
        priority: 1,
      ),

      _gameStatusLabel = TextComponent(
        position: size/2,
        anchor: Anchor.center,
        priority: 1,
        size: Vector2(250, 250),
        textRenderer: statusRender,
      ),

    ];
  }

  @override
  void update(double dt) {
    super.update(dt);
    _scoreText.text = 'Score: $_score';
    _componentCounter.text = 'Components: ${descendants().length}';
  }

  /// Whether all batch groups are currently enabled.
  bool get batchingEnabled => bulletGroup.batchingEnabled;

  void _updateBatchingLabel() {
    _batchingText.text =
        'Batching: ${batchingEnabled ? "ON" : "OFF"}  [press B to toggle]';

    _batchingText.textRenderer = TextPaint(
      style: batchingEnabled ? _textStyleGreen.style : _textStyleRed.style,
    );
  }

  @override
  void onDragStart(DragStartEvent event) {
    if(isPaused)
    {
      return;
    }    
    _player.beginFire();
    super.onDragStart(event);
  }

  @override
  void onDragEnd(DragEndEvent event) {
    if(isPaused)
    {
      return;
    }  
    _player.stopFire();
    super.onDragEnd(event);
  }

  @override
  void onDragCancel(DragCancelEvent event) {
    if(isPaused)
    {
      return;
    }  
    _player.stopFire();
    super.onDragCancel(event);
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    if(isPaused)
    {
      return;
    }  
    _player.position += event.canvasDelta;
    super.onDragUpdate(event);
  }

  void increaseScore() {
    if(isPaused)
    {
      return;
    }  
    _score++;
  }

  void playerGotHit(){
    _life--;
    if(_life<=0)
    {
      _life = 0;
      _isPaused = true;
      //GAME OVER
      processGameOver().ignore();
    }
  }

  Future<void> processGameOver() async 
  {
    final duration  = const Duration(seconds: 2);
    _gameStatusLabel.text = "GAME OVER";

    await Future.delayed(duration);

    onGameOver();
  }
}

class BatchGroup extends PositionComponent with HasAutoBatchedChildren {
  BatchGroup({super.priority, bool batchingEnabled = false}) {
    this.batchingEnabled = batchingEnabled;
  }
}