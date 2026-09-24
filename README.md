# Flutter-Mobile-Game

## Spaceship Survivor Mobile Game for Android and iOS made by Flutter

### The purpose of this project is to exercise and learning more about the Flutter Architecture for Mobile Games, the Dart language and the Flame Engine for gameplay layer.

The implementation includes: 

- MVCS (https://pvha.hashnode.dev/mvcs-architecture) for the entire game screens, navigation, and components.
- Flame Engine usage on the core GamePlay (https://flame-engine.org/)
- Game conditions: Enemy/Player/Bullet Colission, Count Points, Life Damage, Pause, Save, Game Over during game session
- Service Locator (Dependency Injection) for the account layer (UserAccount) 
- Score Ranking saved in local disk (JSON file)
- Event-Driven approach between game layer (Flame) throught other widgets outside (Menu).
 
[!media/spaceship-video.gif]