import 'package:easy_mask/easy_mask.dart';

class InputMask {
  static List<TextInputMask> phoneMask() {
    return [
      TextInputMask(
        mask: ['(99) 99999-9999])'],
        reverse: false,
      )
    ];
  }

  static List<TextInputMask> cpfMask() {
    return [
      TextInputMask(
        mask: ['999.999.999-99])'],
        reverse: false,
      )
    ];
  }

  static List<TextInputMask> dateMask() {
    return [
      TextInputMask(
        mask: ['99/99/9999])'],
        reverse: false,
      )
    ];
  }
}
