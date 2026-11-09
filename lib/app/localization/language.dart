import 'package:foodnanny/app/localization/english.dart';
import 'package:get/get_navigation/src/root/internacionalization.dart';

import 'arabic.dart';
import 'bangla.dart';

class Languages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': english,
        'ar_AR': arabic,
        'bn': bangla,
      };
}
