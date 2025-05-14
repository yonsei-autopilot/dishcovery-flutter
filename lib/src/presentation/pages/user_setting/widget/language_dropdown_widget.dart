import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_menu_flutter/src/config/theme/body_text.dart';
import 'package:smart_menu_flutter/src/config/theme/color.dart';
import 'package:smart_menu_flutter/src/domain/usecases/language_usecase.dart';
import 'package:smart_menu_flutter/src/presentation/notifiers/language_notifier.dart';

final languageListProvider = FutureProvider<List<String>>((ref) async {
  final useCase = ref.read(languageUseCaseProvider);
  return await useCase.getList();
});

class LanguageDropdownWidget extends ConsumerStatefulWidget {
  const LanguageDropdownWidget({super.key});

  @override
  LanguageDropdownWidgetState createState() => LanguageDropdownWidgetState();
}

class LanguageDropdownWidgetState
    extends ConsumerState<LanguageDropdownWidget> {
  @override
  Widget build(BuildContext context) {
    final languageListAsync = ref.watch(languageListProvider);
    final currentLangAsync = ref.watch(languageProvider);

    return languageListAsync.when(
      loading: () => const CircularProgressIndicator(),
      error: (err, stack) => Text('Error: $err'),
      data: (languages) => currentLangAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error loading sel: $e')),
        data: (currentLang) {
          return DropdownButtonHideUnderline(
            child: DropdownButton2<String>(
              value: currentLang,
              hint: Container(
                alignment: Alignment.centerLeft,
                child: const BodyText(
                  text: "Choose Preferred Language",
                  size: 15,
                  color: Color(0xff8C8C8C),
                ),
              ),
              items: languages.map((lang) {
                return DropdownMenuItem(
                  value: lang,
                  child:
                      BodyText(text: lang, size: 15, color: const Color(0xff8C8C8C)),
                );
              }).toList(),
              onChanged: (newLang) {
                if (newLang != null) {
                  ref.read(languageProvider.notifier).updateLanguage(newLang);
                }
              },
              buttonStyleData: ButtonStyleData(
                width: MediaQuery.of(context).size.width - 70,
                height: 50,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: currentLang == null
                      ? const Color(0xffD9D9D9)
                      : primaryLightGreen,
                  borderRadius: BorderRadius.circular(11),
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 5,
                      offset: Offset(1, 2),
                      color: Color(0xffC8C8C8)
                    )
                  ]
                ),
              ),
              dropdownStyleData: DropdownStyleData(
                maxHeight: MediaQuery.of(context).size.height * 0.55,
                width: MediaQuery.of(context).size.width - 70,
                decoration: BoxDecoration(
                  color: const Color(0xffF5F5F5),
                  borderRadius: BorderRadius.circular(15),
                ),
                offset: const Offset(0, -20),
                scrollbarTheme: ScrollbarThemeData(
                  radius: const Radius.circular(20),
                  thickness: MaterialStateProperty.all(6),
                  thumbVisibility: MaterialStateProperty.all(true),
                  thumbColor:
                      MaterialStateProperty.all(const Color(0xffABABAB)),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
