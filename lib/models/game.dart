import 'dart:io';
import 'dart:math';

import 'package:text_dungeon/models/character.dart';
import 'package:text_dungeon/models/monster.dart';

class Game {
  Character? character;
  List<Monster> monsters = [];
  int defeatedMonsters = 0;
  final Random random = Random();

  Future<void> loadCharacterStats(String name) async {
    try {
      final file = File('characters.txt');
      final contents = file.readAsStringSync();
      final stats = contents.split(',');

      if (stats.length != 3)
        throw const FormatException('캐릭터 데이터 형식이 잘못되었습니다.');

      int health = int.parse(stats[0]);
      int attack = int.parse(stats[1]);
      int defense = int.parse(stats[2]);

      character = Character(name, health, attack, defense);
    } catch (e) {
      print('캐릭터 데이터를 불러오는 데 실패했습니다: $e');
      exit(1);
    }
  }

  Future<void> loadMonsterStats() async {
    try {
      final file = File('monsters.txt');
      final contents = file.readAsStringSync();
      final monsterLines = contents.split('\n');

      for (final line in monsterLines) {
        if (line.trim().isEmpty) continue;

        final stats = line.split(',');
        if (stats.length != 3)
          throw FormatException('몬스터 데이터 형식이 잘못되었습니다: $line');

        String name = stats[0];
        int health = int.parse(stats[1]);
        int maxAttack = int.parse(stats[2]);

        // 몬스터의 공격력은 캐릭터의 방어력보다 작을 수 없음
        int attack = max(character?.defense ?? 0, random.nextInt(maxAttack));

        monsters.add(Monster(name, health, attack));
      }
    } catch (e) {
      print('몬스터 데이터를 불러오는 데 실패했습니다: $e');
      exit(1);
    }
  }

  String getCharacterName() {
    String? name;
    final regex = RegExp(r'^[a-zA-Z가-힣]+$');

    while (name == null || name.isEmpty || !regex.hasMatch(name)) {
      stdout.write('캐릭터의 이름을 입력하세요 (한글 또는 영문만 가능): ');
      name = stdin.readLineSync()?.trim();

      if (name == null || name.isEmpty) {
        print('이름을 입력해주세요.');
      } else if (!regex.hasMatch(name)) {
        print('이름은 한글 또는 영문만 가능합니다.');
      }
    }

    return name;
  }

  Monster getRandomMonster() {
    if (monsters.isEmpty) {
      throw Exception('더 이상 몬스터가 없습니다.');
    }
    return monsters[random.nextInt(monsters.length)];
  }

  Future<void> battle(Monster monster) async {
    print('\n===== 전투 시작 =====');
    print('${character!.name}가 ${monster.name}와 전투를 시작합니다!');
  }

  Future<void> startGame() async {
    print('===== 텍스트 던전 RPG 게임 =====');

    final name = getCharacterName();
    await loadCharacterStats(name);
    await loadMonsterStats();

    print('\n게임을 시작합니다!');
    print('${character!.name}님, 당신은 ${monsters.length}마리의 몬스터를 물리쳐야 합니다.');
  }
}
