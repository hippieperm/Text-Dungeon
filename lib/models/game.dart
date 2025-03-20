import 'dart:io';

class Game {
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
