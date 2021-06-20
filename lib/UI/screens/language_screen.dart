import 'package:flutter/material.dart';
import 'package:movies_app/UI/widgets/app_drawer.dart';
import 'package:movies_app/helpers/config.dart';
import 'package:movies_app/locale/app_localization.dart';

class LanguageScreen extends StatefulWidget {
  static const routeName = '/language-screen';

  @override
  _LanguageScreenState createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalization.of(context).language,
        ),
      ),
      drawer: AppDrawer(),
      body: Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ListTile(
              title: Text('English'),
              subtitle: Text(
                'English',
                style: TextStyle(color: Theme.of(context).hintColor),
              ),
              onTap: () {
                setState(() {
                  AppLocalization.load(Locale('en', 'US'));
                  box.put('selectedLanguage', 'en');
                });
              },
            ),
            ListTile(
              title: Text('فارسی'),
              subtitle: Text(
                'Persian',
                style: TextStyle(color: Theme.of(context).hintColor),
              ),
              onTap: () {
                setState(() {
                  AppLocalization.load(Locale('fa', 'IR'));
                  box.put('selectedLanguage', 'fa');
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
