enum SectionEnum { social, app, card, bank, other, custom }

extension SectionEnumExtension on SectionEnum {
  String get name {
    switch (this) {
      case SectionEnum.social:
        return 'Social';
      case SectionEnum.app:
        return 'App';
      case SectionEnum.card:
        return 'Card';
      case SectionEnum.bank:
        return 'Bank';
      case SectionEnum.other:
        return 'Other';
      case SectionEnum.custom:
        return 'Custom';
    }
  }

  static SectionEnum fromString(String value) {
    switch (value) {
      case 'Social':
        return SectionEnum.social;
      case 'App':
        return SectionEnum.app;
      case 'Card':
        return SectionEnum.card;
      case 'Bank':
        return SectionEnum.bank;
      case 'Other':
        return SectionEnum.other;
      case 'Custom':
        return SectionEnum.custom;
      default:
        return SectionEnum.other;
    }
  }
}
