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

  void attackMonster(Monster monster) {
    // 캐릭터 -> 몬스터 공격 로직
    int damage = attack - monster.defense;
    if (damage < 0) damage = 0;

    monster.health -= damage;
    if (monster.health < 0) monster.health = 0;

    print('$name이(가) ${monster.name}에게 $damage 데미지를 입혔습니다!');
  }

  void defend(Monster monster) {
    //캐릭터 방어로직
    int monsterDamage = monster.attack - defense;
    if (monsterDamage < 0) monsterDamage = 0;

    health += monsterDamage;
    print('$name이(가) 방어하여 $monsterDamage만큼 체력을 회복했습니다!');
  }

  void useItem() {
    // 아이템사용
    if (!itemUsed) {
      itemUsed = true;
      int originalAttack = attack;
      attack *= 2;
      print('$name이(가) 특수 아이템을 사용하여 공격력이 두 배로 증가했습니다! 현재 공격력: $attack');

      // 아이템 효과는 한 턴만 지속
      Future.delayed(const Duration(milliseconds: 100), () {
        attack = originalAttack;
      });
    } else {
      print('이미 아이템을 사용했습니다!');
    }
  }

  void showStatus() {
    print('[$name] 체력: $health | 공격력: $attack | 방어력: $defense');
  }
}
