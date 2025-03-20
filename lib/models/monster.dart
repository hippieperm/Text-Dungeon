// ignore_for_file: public_member_api_docs, sort_constructors_first
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
}
