import 'dart:io';

import 'package:text_dungeon/models/character.dart';

class Game {
  Character? character;

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

  void startGame() {
    print('===== 텍스트 던전 RPG 게임 =====');
    final name = getCharacterName();
  }
}
