enum Gender { man, woman, unknown }

extension Genderxtension on Gender {
  int get num {
    switch (this) {
      case Gender.man:
        return 1;
      case Gender.woman:
        return 2;
      case Gender.unknown:
        return 3;
    }
  }

  String get childLabel {
    switch (this) {
      case Gender.man:
        return '男の子';
      case Gender.woman:
        return '女の子';
      case Gender.unknown:
        return '不明';
    }
  }

  String get childCall {
    switch (this) {
      case Gender.man:
        return 'くん';
      case Gender.woman:
        return 'ちゃん';
      case Gender.unknown:
        return '';
    }
  }

  String get adultLabel {
    switch (this) {
      case Gender.man:
        return '男性';
      case Gender.woman:
        return '女性';
      case Gender.unknown:
        return '選択しない';
    }
  }
}
