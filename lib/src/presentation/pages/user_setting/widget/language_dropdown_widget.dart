import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_menu_flutter/src/config/theme/body_text.dart';
import 'package:smart_menu_flutter/src/config/theme/color.dart';
import 'package:smart_menu_flutter/src/domain/usecases/language_usecase.dart';

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
  String? selectedLanguage;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    double height = size.height;
    double width = size.width;

    final languageAsync = ref.watch(languageListProvider);
    return languageAsync.when(
        loading: () => const CircularProgressIndicator(),
        error: (err, stack) => Text('Error: $err'),
        data: (languages) =>
            DropdownButtonHideUnderline(
              child: DropdownButton2<String>(
                buttonStyleData: ButtonStyleData(
                    width: width - 70,
                    height: 50,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                        color: selectedLanguage == null ? const Color(0xffD9D9D9) : primaryLightGreen,
                        borderRadius: BorderRadius.circular(11)
                    )
                ),
                dropdownStyleData: DropdownStyleData(
                    maxHeight: height * 0.55,
                    width: width - 70,
                  decoration: BoxDecoration(
                    color: const Color(0xffF5F5F5),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  offset: const Offset(0, -20),
                  scrollbarTheme: ScrollbarThemeData(
                    radius: const Radius.circular(20),
                    thickness: MaterialStateProperty.all(6),
                    thumbVisibility: MaterialStateProperty.all(true),
                    thumbColor: MaterialStateProperty.all(const Color(0xffABABAB))
                  )
                ),
                selectedItemBuilder: (context) {
                  return languages.map((item) {
                    return Container(
                      alignment: Alignment.centerLeft,
                      child: BodyText(
                          text: item,
                          color: selectedLanguage == null
                              ? primaryGrey
                              : primaryBlack
                      ),
                    );
                  }).toList();
                },
                hint: Container(
                  alignment: Alignment.centerLeft,
                  child: const BodyText(text: "Choose Preferred Language",
                    size: 15,
                    color: Color(0xff8C8C8C),),
                ),
                items: languages.map((item) {
                  final bool isSelected = item == selectedLanguage;
                  return DropdownMenuItem<String>(
                    value: item,
                    child: BodyText(
                      text: item,
                      size: 15,
                      color: const Color(0xff8C8C8C),
                    ),
                  );
                }).toList(),
                value: selectedLanguage,
                onChanged: (value) {
                  setState(() {
                    selectedLanguage = value;
                  });
                },
              ),
            )
    );
  }
}
