// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:text_dungeon/models/character.dart';

class Monster {
  String name;
  int health;
  int attack;
  int defense = 0;
  int turnCount = 0;

  Monster({
    required this.name,
    required this.health,
    required this.attack,
  });

  void attackCharacter(Character character) {
    int demage = attack - character.defense;
    if (demage < 0) demage = 0;
  }
}
