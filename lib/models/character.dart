// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:text_dungeon/models/monster.dart';

class Character {
  String name;
  int health;
  int attack;
  int defense;
  bool itemUsed = false;

  Character({
    required this.name,
    required this.health,
    required this.attack,
    required this.defense,
  });

  void attackMonster(Monster monster) { // 캐릭터 -> 몬스터 공격 로직
    int damage = attack - monster.defense;
    if (damage < 0) damage = 0;

    monster.health -= damage;
    if (monster.health < 0) monster.health = 0;

    print('$name이(가) ${monster.name}에게 $damage 데미지를 입혔습니다!');
  }

  void showStatus() {
    print('[$name] 체력: $health | 공격력: $attack | 방어력: $defense');
  }
}
