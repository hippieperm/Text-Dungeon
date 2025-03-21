# 텍스트 던전 RPG 게임

이 프로젝트는 Dart로 작성된 텍스트 기반 던전 RPG 게임입니다.
![스크린샷 2025-03-21 오전 3 23 39](https://github.com/user-attachments/assets/118f1a4b-5683-4dab-903c-05be567a554f)



## 기능

- 캐릭터 생성 및 몬스터와의 전투
- 랜덤 몬스터 선택 기능
- 파일에서 캐릭터와 몬스터 데이터 로드
- 게임 결과 저장
- 특수 아이템 사용 기능
- 몬스터 방어력 자동 증가 기능

## 실행 방법

```bash
dart lib/main.dart
```

## 게임 조작 방법

- 게임 시작 시 캐릭터 이름을 입력합니다.
- 전투 중 다음 액션을 선택할 수 있습니다:
  - 1: 공격하기
  - 2: 방어하기
  - 3: 아이템 사용하기 (한 번만 가능)
- 몬스터를 물리친 후 다음 몬스터와 대결할지 선택할 수 있습니다.

## 파일 구조

- `lib/main.dart`: 메인 프로그램 진입점
- `lib/models/character.dart`: 캐릭터 클래스 정의
- `lib/models/monster.dart`: 몬스터 클래스 정의
- `lib/models/game.dart`: 게임 로직 클래스 정의
- `characters.txt`: 캐릭터 기본 스탯 데이터
- `monsters.txt`: 몬스터 데이터
- `result.txt`: 게임 결과 저장 파일


트러블슈팅
https://velog.io/@hippieperm/Flutter에서-Named-Parameters와-Positional-Parameters-완벽-이해하기
