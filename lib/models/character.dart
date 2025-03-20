// ignore_for_file: public_member_api_docs, sort_constructors_first
class Character {
  String name;
  int health;
  int attack;
  int defense;
  bool itemUsed = false;

  Character(
    this.name,
    this.health,
    this.attack,
    this.defense,
  );

  void showStatus() {
    print('[$name] 체력: $health | 공격력: $attack | 방어력: $defense');
  }
}
