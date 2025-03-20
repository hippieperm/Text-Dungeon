import 'dart:io';
import 'dart:math';

import 'package:text_dungeon/models/character.dart';
import 'package:text_dungeon/models/monster.dart';

class Game {
  Character? character;
  List<Monster> monsters = [];
  int defeatedMonsters = 0; //잡은 몬스터 수
  final Random random = Random();

  Future<void> loadCharacterStats(String name) async {
    //캐릭터 정보 로드
    try {
      final file = File('characters.txt');
      final contents = file.readAsStringSync();
      final stats = contents.split(',');

      if (stats.length != 3)
        throw const FormatException('캐릭터 데이터 형식이 잘못되었습니다.');

      int health = int.parse(stats[0]);
      int attack = int.parse(stats[1]);
      int defense = int.parse(stats[2]);

      character = Character(
        name: name,
        health: health,
        attack: attack,
        defense: defense,
      );
    } catch (e) {
      print('캐릭터 데이터를 불러오는 데 실패했습니다: $e');
      exit(1);
    }
  }

  Future<void> loadMonsterStats() async {
    // 몬스터정보 로드
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

        monsters.add(Monster(
          name: name,
          health: health,
          attack: attack,
        ));
      }
    } catch (e) {
      print('몬스터 데이터를 불러오는 데 실패했습니다: $e');
      exit(1);
    }
  }

  String getCharacterName() {
    // 캐릭터 이름 입력받기
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
    // 몬스터 랜덤으로 불러오기
    if (monsters.isEmpty) {
      throw Exception('더 이상 몬스터가 없습니다.');
    }
    return monsters[random.nextInt(monsters.length)];
  }

  Future<void> battle(Monster monster) async {
    print('\n===== 전투 시작 =====');
    print('${character!.name}가 ${monster.name}와 전투를 시작합니다!');

    while (character!.health > 0 && monster.health > 0) {
      character!.showStatus();
      monster.showStatus();

      stdout.write('행동을 선택하세요: 1) 공격하기 2) 방어하기');
      if (!character!.itemUsed) {
        stdout.write(' 3) 아이템 사용하기');
      }
      stdout.write('\n> ');

      String? input = stdin.readLineSync();

      switch (input) {
        case '1':
          character!.attackMonster(monster);
          break;
        case '2':
          character!.defend(monster);
          break;
        case '3':
          if (!character!.itemUsed) {
            character!.useItem();
            character!.attackMonster(monster);
          } else {
            print('이미 아이템을 사용했습니다. 다시 선택해주세요.');
            continue;
          }
          break;
        default:
          print('잘못된 입력입니다. 다시 선택해주세요.');
          continue;
      }

      if (monster.health <= 0) {
        print('${monster.name}을(를) 물리쳤습니다!');
        defeatedMonsters++;
        // 처치한 몬스터 제거
        monsters.remove(monster);
        break;
      }

      monster.attackCharacter(character!);

      if (character!.health <= 0) {
        print('${character!.name}가 쓰러졌습니다...');
        break;
      }

      print('');
    }
  }

  Future<void> startGame() async {
    print('===== 텍스트 던전 RPG 게임 =====');

    final name = getCharacterName();
    await loadCharacterStats(name);
    await loadMonsterStats();

    print('\n게임을 시작합니다!');
    print('${character!.name}님, 당신은 ${monsters.length}마리의 몬스터를 물리쳐야 합니다.');

    while (character!.health > 0 &&
        defeatedMonsters < monsters.length &&
        monsters.isNotEmpty) {
      Monster currentMonster = getRandomMonster();
      await battle(currentMonster);

      if (character!.health <= 0) break;

      if (monsters.isNotEmpty) {
        stdout.write('다음 몬스터와 대결하시겠습니까? (y/n): ');
        String? input = stdin.readLineSync()?.toLowerCase();

        if (input != 'y') {
          print('게임을 종료합니다.');
          break;
        }
      }
    }

    String result;

    if (defeatedMonsters >= monsters.length || monsters.isEmpty) {
      result = '승리';
      print('\n축하합니다! 모든 몬스터를 물리쳤습니다!');
    } else {
      result = '패배';
      print('\n게임 오버! 다음에 다시 도전해보세요.');
    }
  }
}
