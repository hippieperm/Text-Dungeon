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
    int damage = attack - character.defense;
    if (damage < 0) damage = 0;

    character.health -= damage;
    if (character.health < 0) character.health = 0;

    print('$name이(가) ${character.name}에게 $damage 데미지를 입혔습니다!');

    // 3턴마다 방어력 증가
    turnCount++;
    if (turnCount % 3 == 0) {
      defense += 2;
      print('$name의 방어력이 증가했습니다! 현재 방어력: $defense');
    }
  }
}
