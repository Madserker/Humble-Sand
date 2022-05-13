import 'package:flutter/material.dart';
import 'package:humble_sand/src/domain/services/translations_service.dart';
import 'package:humble_sand/src/locator_manager.dart';

import '../../../generated/l10n.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

// TODO: add Provider and apply the UI design
class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    String lang = locator<TranslationsService>().currentLanguage;
    int _selectedIndex =
        locator<TranslationsService>().supportedLocales.indexOf(lang);

    return Center(
      child: Container(
        width: 300,
        height: 300,
        child: Column(
          children: [
            ListView.builder(
                shrinkWrap: true,
                itemCount:
                    locator<TranslationsService>().supportedLocales.length,
                itemBuilder: (BuildContext context, int index) {
                  return RadioListTile(
                    title: Text(
                      locator<TranslationsService>().keyToString(
                        locator<TranslationsService>().supportedLocales[index],
                        context,
                      ),
                    ),
                    value:
                        locator<TranslationsService>().supportedLocales[index],
                    groupValue: locator<TranslationsService>()
                        .supportedLocales[_selectedIndex],
                    onChanged: (String? value) {
                      setState(() {
                        _selectedIndex = index;
                        locator<TranslationsService>()
                            .changeLanguage(value ?? '');
                      });
                    },
                  );
                }),
            ElevatedButton(
              child: Text("Change language to ca"),
              onPressed: () {
                setState(() {
                  locator<TranslationsService>().changeLanguage("ca_ES");
                });
              },
            ),
            ElevatedButton(
              child: Text("Change language to es"),
              onPressed: () {
                setState(() {
                  locator<TranslationsService>().changeLanguage("es_ES");
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
